From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 1/4] test-suite: adding a test for fast-export with tag 
	variants
Date: Sun, 29 Mar 2009 22:05:36 +0200
Message-ID: <40aa078e0903291305p28ec2ae8xf0cb465e593af0b0@mail.gmail.com>
References: <1237812789-1360-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 22:10:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo1Kg-0002FC-JX
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 22:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184AbZC2UFl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Mar 2009 16:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbZC2UFk
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 16:05:40 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:12558 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbZC2UFj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2009 16:05:39 -0400
Received: by ey-out-2122.google.com with SMTP id 4so526591eyf.37
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 13:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=csAXELbu+2VW9cj5HpUg78NvGKaIdkYqaZGFQIT+LAE=;
        b=aClSc26AuAr+/nQSu7oeZVe2Nk6G/zW/W80/wjt7TqrEXXMM8osu8Hwm6NFTImbkSE
         6aEq6v5JZBDu4DCdA64rFn9w1+jPUq67rTuz9gNfwQm7Exml4NOKc011uE8Gfj72zdis
         oN/mNbYIDJbRItub0anL5VEaTmDJJUQqbEhws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sZKXyUcOt05P0VbOslCM+fvX+C2Vqh9GzxG7KD6IxYHIqNDNFjR5JbM3JDdi6abxlk
         DFCEY0oabJKHMDVSjp8pe2QrDAYGWBHEUiaT/S6TSuDdSjYr52a5pWjEG+UEDOl+c2k1
         ZtLQCo+i98cJYpIrydojoR97RsMmu49aHaO/U=
Received: by 10.210.21.13 with SMTP id 13mr3533276ebu.52.1238357136371; Sun, 
	29 Mar 2009 13:05:36 -0700 (PDT)
In-Reply-To: <1237812789-1360-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115033>

OK, I see now that the previous patch-series has been merged to "pu".
Is there a reason why this updated patch-series hasn't superseded it?
Did I do something wrong when I resubmitted it? And what do I need to
do to get these patches going forward from there?

On Mon, Mar 23, 2009 at 2:53 PM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> The first two new tests are crashing, so I'm adding them commented ou=
t as they
> exit with unpredictable return-codes.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
> =A0t/t9301-fast-export.sh | =A0 14 +++++++++++++-
> =A01 files changed, 13 insertions(+), 1 deletions(-)
>
> diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
> index 86c3760..db4b0b3 100755
> --- a/t/t9301-fast-export.sh
> +++ b/t/t9301-fast-export.sh
> @@ -28,7 +28,12 @@ test_expect_success 'setup' '
> =A0 =A0 =A0 =A0git commit -m sitzt file2 &&
> =A0 =A0 =A0 =A0test_tick &&
> =A0 =A0 =A0 =A0git tag -a -m valentin muss &&
> - =A0 =A0 =A0 git merge -s ours master
> + =A0 =A0 =A0 git merge -s ours master &&
> + =A0 =A0 =A0 HEAD_TREE=3D`git show -s --pretty=3Draw HEAD | grep tre=
e | sed "s/tree //"` &&
> + =A0 =A0 =A0 git tag =A0 =A0tree_tag =A0 =A0 =A0 =A0-m "tagging a tr=
ee" $HEAD_TREE &&
> + =A0 =A0 =A0 git tag -a tree_tag-obj =A0 =A0-m "tagging a tree" $HEA=
D_TREE &&
> + =A0 =A0 =A0 git tag =A0 =A0tag-obj_tag =A0 =A0 -m "tagging a tag" t=
ree_tag-obj &&
> + =A0 =A0 =A0 git tag -a tag-obj_tag-obj -m "tagging a tag" tree_tag-=
obj
>
> =A0'
>
> @@ -259,4 +264,11 @@ test_expect_success 'cope with tagger-less tags'=
 '
>
> =A0'
>
> +# NEEDSWORK: not just check return status, but validate the output
> +# two tests commented out due to crash and thus unreliable return co=
de
> +#test_expect_success 'tree_tag' =A0 =A0 =A0 =A0'git fast-export tree=
_tag'
> +#test_expect_success 'tree_tag-obj' =A0 =A0'git fast-export tree_tag=
-obj'
> +test_expect_failure 'tag-obj_tag' =A0 =A0 'git fast-export tag-obj_t=
ag'
> +test_expect_failure 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-o=
bj'
> +
> =A0test_done
> --
> 1.6.2.1.225.g9a4a0.dirty
>
>



--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
