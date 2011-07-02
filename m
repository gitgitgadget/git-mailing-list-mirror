From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Heitzmann?= 
	<frederic.heitzmann@gmail.com>
Subject: Re: [PATCH] git svn : hook before 'git svn dcommit'
Date: Sat, 02 Jul 2011 19:25:25 +0200
Message-ID: <4E0F5485.9010201@gmail.com>
References: <4E0F1383.8080804@gmail.com> <vpqboxcu6td.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jul 02 19:25:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qd3wm-0000pp-4n
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 19:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127Ab1GBRZb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jul 2011 13:25:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44874 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab1GBRZa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 13:25:30 -0400
Received: by bwd5 with SMTP id 5so3273859bwd.19
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 10:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BVqcx6WsLkOnM1BPAeiuTu6LwQlkhf9/z8ygRDmO7jM=;
        b=ingB3ILFA+Y53bC6ZkXh4r51ouy2oomGtyfVIzNUJnEY2vNBZlVzvkLpCmEdhDowOX
         Afc/l5asF0ty645OMRUTv1ATNQEAr9SymDEm+bwHEcglnysL+cOiTMA7eLtz7d+jDiJA
         vh/GhCB8UspdlRABxOKkOVtcyQ3bKlKgQEYGk=
Received: by 10.204.36.134 with SMTP id t6mr4023252bkd.57.1309627528925;
        Sat, 02 Jul 2011 10:25:28 -0700 (PDT)
Received: from [192.168.0.10] (dra38-7-88-179-84-80.fbx.proxad.net [88.179.84.80])
        by mx.google.com with ESMTPS id m6sm1915550fac.3.2011.07.02.10.25.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Jul 2011 10:25:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
In-Reply-To: <vpqboxcu6td.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176562>


Le 02/07/2011 15:54, Matthieu Moy a =E9crit :
> Fr=E9d=E9ric Heitzmann<frederic.heitzmann@gmail.com>  writes:
>
>> The 'pre-svn-dcommit' hook si called before 'git svn dcommit', which=
 aborts
>> if return value is not zero.
>> ---
>>   git-svn.perl |   19 +++++++++++++++++++
> What about documentation?
Should documentation be part of githooks or git-svn man page ?
I vote for the latest, in order to avoid
In any case, what do you think of the following help message ?

+HOOKS
+-----
+
+The 'pre-svn-dcommit' hook is called by 'git svn dcommit' and can be=20
used to
+prevent some diff to be committed to a SVN repository. It may typicall=
y be
+used to filter some intermediate patches, which were committed into gi=
t but
+must not find their way to the SVN repository.
+
+If the hook exists with a non zero-status, 'git svn dcommit' will abor=
t.
+
+

[...]

  SEE ALSO
  --------
-linkgit:git-rebase[1]
+linkgit:git-rebase[1], linkgit:githooks[5]

--=20

>> +       if ($? =3D=3D -1) {
>> +               print "[pre_svn_dcommit_hook] failed to execute $hoo=
k:
>> $!\n";
> whitespace damage (extra newline)
>

As for the 'whitespace damage", I do not understand what you mean.
The \n look mandatory to me.
You may look at 'info perlfunc' for the original code snippet (see=20
'system' function).

--
=46red
