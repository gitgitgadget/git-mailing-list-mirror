From: William Pursell <bill.pursell@gmail.com>
Subject: Re: permissions
Date: Wed, 09 Jun 2010 00:29:04 -1000
Message-ID: <4C0F6CF0.3020603@wpursell.net>
References: <4C0A19FE.1020802@wpursell.net>	<m27hmdn704.fsf@igel.home>	<4C0A9615.4090307@wpursell.net>	<AANLkTileRHwUuJpvKJbivRiM9Prn9wJ0zH6abExBgcq0@mail.gmail.com>	<4C0B6C32.1090700@wpursell.net>	<7vvd9wvswy.fsf@alter.siamese.dyndns.org>	<4C0E1AB1.2030702@wpursell.net>	<AANLkTimAmSxq8dC-4bnpLsvN3JabQeTO6pDTh9ds7D0D@mail.gmail.com>	<7vtypds09x.fsf@alter.siamese.dyndns.org>	<4C0EC3D0.6060509@wpursell.net> <AANLkTikGpbeP1ba0y0oUsWGQXsrL8Z-GKjybCB83W_FJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: William Pursell <bill.pursell@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 12:29:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMIX7-0005JY-2z
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 12:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757455Ab0FIK3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 06:29:11 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:42734 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757391Ab0FIK3K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 06:29:10 -0400
Received: by pzk32 with SMTP id 32so2832770pzk.21
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 03:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=VxmzTNK2AO3yb2hr0XbEN4qyQj8J0Rzbbx2QN2Rs/I4=;
        b=xZqVsutVs2iDhNn7L3E3/ZPvXJMYWvMhd0RYP3bE1DwBtEjAIZ3ndLEJayV5gtB8Ap
         LryXAuloVl4naMbd/E3sBcquoHEm0KLvszhDZ/BB8vOJ7KkwM6tnoad5rbdj521Iz4aB
         j49X+MaZWmkNx0zfnVNP4uTiHflWM2RhNkMes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=YIQXWZUlGmw8TDYJEeMhRZwHewGMWAm8XT9aOpibPR48+/zo2woKILNKND8HKdoLCt
         Yr46bteInfIDoQC1RwubEIkhLD4E04h5ur9NeF/4kQygZYibcvvJw9aPIyJiX2693TUq
         5ElCA3VLvu4q0zc4rgasjuZ/qAori9cFkyBFI=
Received: by 10.115.98.17 with SMTP id a17mr1142755wam.74.1276079349010;
        Wed, 09 Jun 2010 03:29:09 -0700 (PDT)
Received: from clam.westell.com (udp278831uds.hawaiiantel.net [72.234.51.251])
        by mx.google.com with ESMTPS id d16sm62585106wam.12.2010.06.09.03.29.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Jun 2010 03:29:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (Macintosh/20100228)
In-Reply-To: <AANLkTikGpbeP1ba0y0oUsWGQXsrL8Z-GKjybCB83W_FJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148760>

Alex Riesen wrote:
> On Wed, Jun 9, 2010 at 00:27, William Pursell <bill.pursell@gmail.com> wrote:
>> Junio C Hamano wrote:
>>> Alex Riesen <raa.lkml@gmail.com> writes:
>>>
>>>> On Tue, Jun 8, 2010 at 12:25, William Pursell <bill.pursell@gmail.com> wrote:
>>>>> Here's a patch.  This doesn't address the issue of a damaged
>>>>> repository, but just catches access errors and permissions.
>>>> The change looks fishy.
>>>>
>>>> The patch moves the function is_git_directory at the level of user
>>>> interface where it wasn't before: it now complains and die.
>>>> Not all callers of the function call it only to die if it fails.
>>> Thanks for shooting it down before I had to look at it ;-)
>> The point of the patch is that it now complains and dies.
> 
> At wrong point. Points, actually. There are many callers of the
> function you modified. You should have looked at them all.

I did look at all 4 calls, and it seemed to me
that localizing the change in one location is a better
design than adding logic to 4 different locations.

>> Perhaps I'm being obtuse, but can you describe a situation
>> in which this causes git to terminate inappropriately?
> 
> Maybe. BTW, can you? (if you try, I mean).

No, I can't.  As far as I can tell, the patch adds
exactly the functionality that I want it to add.  You
do make good points about its problems below, however,
and you are right that I did miss the point of
your criticism.  Thank you for clarifying.

> But your questions
> misses the point of my complaint about your patch:
> 
> The patch makes the function you modified act not as one
> can guess from its other uses. Imagine someone replaced
> open(2) implementation to kill your program everytime you
> tried to open /etc/passwd. How'd you like that?

I think there is a substantial difference between changing
a basic library call and changing a statically linked
function called from only 4 locations, but I'll agree
that you have a valid point about the function not
behaving as expected.  The functionality I've added disagrees
with the name of the function, so on that point alone I will
agree that the patch is no good.

> 
> That alone is reason enough to dislike the change and put
> you personally into a list of persons to be careful with (as
> you don't seem to care about what happens with the code
> after you changed it).

I do care quite a lot actually.  My primary goal
was to minimize the changes, and it seemed that
is_git_directory() was the right place to make
the change with minimal impact.  Perhaps the following
patch would be more to your liking:


diff --git a/setup.c b/setup.c
index 7e04602..b25da21 100644
--- a/setup.c
+++ b/setup.c
@@ -303,6 +303,9 @@ const char *read_gitfile_gently(const char *path)
 		buf = dir;
 	}

+	if (access(dir, X_OK))
+		die_errno("Unable to access %s", dir);
+
 	if (!is_git_directory(dir))
 		die("Not a git repository: %s", dir);
 	path = make_absolute_path(dir);
@@ -370,6 +373,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			*nongit_ok = 1;
 			return NULL;
 		}
+		if (access(gitdirenv, X_OK))
+			die_errno("Unable to access %s", gitdirenv);
+
 		die("Not a git repository: '%s'", gitdirenv);
 	}

@@ -407,6 +413,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 		if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
 			break;
+		if (access(DEFAULT_GIT_DIR_ENVIRONMENT, X_OK)
+				 && errno != ENOENT )
+			die_errno("Unable to access %s/%s",
+				 cwd, DEFAULT_GIT_DIR_ENVIRONMENT);
+
 		if (is_git_directory(".")) {
 			inside_git_dir = 1;
 			if (!work_tree_env)
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index cb14425..9f6f756 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -46,7 +46,7 @@ test_expect_success 'bad setup: invalid .git file path' '
 		echo "git rev-parse accepted an invalid .git file path"
 		false
 	fi &&
-	if ! grep "Not a git repository" .err
+	if ! grep "Unable to access $REAL.not" .err
 	then
 		echo "git rev-parse returned wrong error"
 		false

-- 
William Pursell
