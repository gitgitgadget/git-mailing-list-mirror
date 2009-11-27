From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] pull: clarify advice for the unconfigured error case
Date: Fri, 27 Nov 2009 08:17:05 -0600
Message-ID: <20091127141704.GA24080@progeny.tock>
References: <48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com>
 <1257965806.26362.132.camel@heerbeest>
 <D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com>
 <1257968052.26362.155.camel@heerbeest>
 <AC99BA30-A36D-4798-8E7D-9D69EFE99D55@dbservice.com>
 <1258035449.26362.273.camel@heerbeest>
 <20091112155310.7836c388@perceptron>
 <20091112150626.GA24848@coredump.intra.peff.net>
 <20091112170814.1858aba4@perceptron>
 <20091113040754.GA3255@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Jeff King <peff@peff.net>,
	Jan Nieuwenhuizen <janneke-list@xs4all.nl>,
	Tomas Carnecky <tom@dbservice.com>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 15:05:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE1Ro-0000i5-2K
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 15:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbZK0OFA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 09:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752982AbZK0OFA
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 09:05:00 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:55715 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949AbZK0OE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 09:04:58 -0500
Received: by ywh12 with SMTP id 12so1670560ywh.21
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 06:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=orpib4oXRlYnu4fsplyGjyqis3UPW0lhJR0GwjJ0w0U=;
        b=LW+YXXqdXVJmm4MEZaZvLpBBgI4ekjdhDtjJvym2FnxBNdcJpEUNAs1nsfE1bVNeF6
         l3eZ/brvkCJDOhg8E7g2fBd6d0knT191ZE9fWJ91w28REiKvSYDgeOpnZQSqna0WF5Fv
         Ly0FGnbp1kT7yAJ/SaJfp4R1qPa/L2RDfz6I4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=uyD/RzuM2a3vy4Z+QHEYmkU4P+ui5w4EJFagFtJnGypQnVQufScnPKNkznLBWUlnxO
         Fc/hK6euT7y+9aG3qlWU3ungbeA6TtPUtIk/NGeoCQZ9pdfkvqc8qxDP1r8Jw52/8xXe
         oD8LcjVdLFqKuX9nttStV4vkZaQzuilJcr0nk=
Received: by 10.101.18.10 with SMTP id v10mr377615ani.148.1259330702603;
        Fri, 27 Nov 2009 06:05:02 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 6sm821461yxg.30.2009.11.27.06.05.00
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 06:05:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091113040754.GA3255@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133894>

=46rom: Jan Kr=C3=BCger <jk@jk.gs>

When pull --rebase fails because it cannot find what branch to
merge against, the error message implies we are trying to merge.
Say "rebase against" instead of "merge with" to avoid confusion.

The configuration suggested to remedy the situation uses a
confusing syntax, with variables specified in the dotted form
accepted by 'git config' but separated from their values by the
'=3D' delimiter used by config files.  Since the user will have to
edit this output anyway, it is more helpful to provide a config
file snippet to paste into an editor and modify.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:
> Jan Kr=C3=BCger wrote:
=20
>> --- a/git-pull.sh
>> +++ b/git-pull.sh
>> @@ -91,45 +91,56 @@ error_on_no_merge_candidates () {
>[...]
>>  	if [ $# -gt 1 ]; then
>> -		echo "There are no candidates for merging in the refs that you ju=
st fetched."
>> +		echo "There are no candidates for using the refs that you just fe=
tched."
>>  		echo "Generally this means that you provided a wildcard refspec w=
hich had no"
>>  		echo "matches on the remote end."
>
> This sounds a little awkward to me, maybe because all the remote refs
> are being used to populate the remotes/<remote>/* hierarchy.

Scratch that --- I was confused.

I still find pull pretty confusing.  In its three forms, it does
different things:

 - 'git pull' fetches from the current branch=E2=80=99s remote (both it=
s
   standard fetch refspec and the current branch=E2=80=99s), then merge=
s any
   branches that match the current branch=E2=80=99s refspec.

 - 'git pull foo' fetches from the specified remote.  If it is
   the current branch=E2=80=99s remote, this is just a synonym for
   'git pull'; otherwise, it first fetches and then complains.

 - 'git pull foo refspec' does a fetch according to the specified
   refspec, and if any branches match, merges them into the
   current branch.

I was worried about the first form before (but who uses wildcards
in their branches=E2=80=99 refspecs?), but as Peff explains in commit
a8c9bef (pull: improve advice for unconfigured error case,
2009-10-05) the third one should be much more common.

In the --rebase case, exactly one branch would have to match for
this to make any sense (there is no such thing as an octopus
rebase), so I reworded the message accordingly.

 git-pull.sh |   48 +++++++++++++++++++++++++++++++++---------------
 1 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 37f3d93..2c384c4 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -91,45 +91,63 @@ error_on_no_merge_candidates () {
 		esac
 	done
=20
+	if test true =3D "$rebase"
+	then
+		op_type=3Drebase
+		op_prep=3Dagainst
+	else
+		op_type=3Dmerge
+		op_prep=3Dwith
+	fi
+
 	curr_branch=3D${curr_branch#refs/heads/}
 	upstream=3D$(git config "branch.$curr_branch.merge")
 	remote=3D$(git config "branch.$curr_branch.remote")
=20
 	if [ $# -gt 1 ]; then
-		echo "There are no candidates for merging in the refs that you just =
fetched."
+		if [ "$rebase" =3D true ]; then
+			printf "There is no candidate for rebasing against "
+		else
+			printf "There are no candidates for merging "
+		fi
+		echo "among the refs that you just fetched."
 		echo "Generally this means that you provided a wildcard refspec whic=
h had no"
 		echo "matches on the remote end."
 	elif [ $# -gt 0 ] && [ "$1" !=3D "$remote" ]; then
 		echo "You asked to pull from the remote '$1', but did not specify"
-		echo "a branch to merge. Because this is not the default configured =
remote"
+		echo "a branch. Because this is not the default configured remote"
 		echo "for your current branch, you must specify a branch on the comm=
and line."
 	elif [ -z "$curr_branch" ]; then
 		echo "You are not currently on a branch, so I cannot use any"
 		echo "'branch.<branchname>.merge' in your configuration file."
-		echo "Please specify which branch you want to merge on the command"
+		echo "Please specify which remote branch you want to use on the comm=
and"
 		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
 		echo "See git-pull(1) for details."
 	elif [ -z "$upstream" ]; then
 		echo "You asked me to pull without telling me which branch you"
-		echo "want to merge with, and 'branch.${curr_branch}.merge' in"
-		echo "your configuration file does not tell me either.	Please"
-		echo "specify which branch you want to merge on the command line and=
"
+		echo "want to $op_type $op_prep, and 'branch.${curr_branch}.merge' i=
n"
+		echo "your configuration file does not tell me, either. Please"
+		echo "specify which branch you want to use on the command line and"
 		echo "try again (e.g. 'git pull <repository> <refspec>')."
 		echo "See git-pull(1) for details."
 		echo
-		echo "If you often merge with the same branch, you may want to"
-		echo "configure the following variables in your configuration"
-		echo "file:"
+		echo "If you often $op_type $op_prep the same branch, you may want t=
o"
+		echo "use something like the following in your configuration file:"
+		echo
+		echo "    [branch \"${curr_branch}\"]"
+		echo "    remote =3D <nickname>"
+		echo "    merge =3D <remote-ref>"
+		test rebase =3D "$op_type" &&
+			echo "    rebase =3D true"
 		echo
-		echo "    branch.${curr_branch}.remote =3D <nickname>"
-		echo "    branch.${curr_branch}.merge =3D <remote-ref>"
-		echo "    remote.<nickname>.url =3D <url>"
-		echo "    remote.<nickname>.fetch =3D <refspec>"
+		echo "    [remote \"<nickname>\"]"
+		echo "    url =3D <url>"
+		echo "    fetch =3D <refspec>"
 		echo
 		echo "See git-config(1) for details."
 	else
-		echo "Your configuration specifies to merge the ref '${upstream#refs=
/heads/}' from the"
-		echo "remote, but no such ref was fetched."
+		echo "Your configuration specifies to $op_type $op_prep the ref '${u=
pstream#refs/heads/}'"
+		echo "from the remote, but no such ref was fetched."
 	fi
 	exit 1
 }
--=20
1.6.5.3
