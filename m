From: dayong xie <dayong1111@gmail.com>
Subject: When a file was locked by some program, git will work stupidly
Date: Mon, 2 Nov 2015 12:56:55 +0800
Message-ID: <CABEb4T7V=WEi-ZZm7ywOFASm+=LtAyOz53gqv-jjuzF-3=veeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 05:57:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zt7Az-0006uc-Ef
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 05:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbbKBE44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 23:56:56 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34375 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbbKBE44 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 23:56:56 -0500
Received: by oies66 with SMTP id s66so88541032oie.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 20:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=MlF3diQ5KlPXuZmwpPsRsRz50NErnaEtFlMoP3fWySs=;
        b=LZerv9sWxmImjlUsxJsl2k7KAzngbUnTrAYbI7cy4TMAtpuhrp2KUx/QWYyl2LH9Sf
         H/KD996fPGJYu4UDXouZ8LyoABTp2keRT4VC9QGO1lQWagiRaOIzjv6VOXGe0OpDrcFC
         NNQybw41YIg9NIVG5paYrPNBtw4ExbNAeAw1AJNus3JZ0hxMPm/3x5g2V7OymrC8o63z
         1jZmqO0TZDQcA1e+JLgt0DqgndZ9HDI8fYcUwdXe1t3yLLqFlD2ksi+zVD2ldiT8J2/t
         6ywHP75M1CrEjM2LxU5Eoah3rZiIgoE8advyr8FYtr4eumwsy1faX/C/fz07gAE7SvhJ
         /sDQ==
X-Received: by 10.202.212.74 with SMTP id l71mr12268432oig.54.1446440215412;
 Sun, 01 Nov 2015 20:56:55 -0800 (PST)
Received: by 10.202.48.144 with HTTP; Sun, 1 Nov 2015 20:56:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280680>

To be specific
In my Unity project, there is a native plugin,  and plugin's extension
is .dll, and this plugin is
under git version control, when Unity is running, the plugin file will
be locked.
If i merge another branch, which contains modification of the plugin,
git will report error, looks
like:
error: unable to unlink old 'xxxxxxx/xxx.dll' (Permission denied)
This is not bad, however, the unfinished merge action will not revert
by git, a lot of changes
produced in repository.
usually it makes me crazy, even worse, some of my partners are not
good at using git.
Of course, this problem can be avoided by quit Unity, but not every
time we can remember. In
my opinion, git should revert the unfinished action when the error
occurred, not just stop.

-- 
--------------------------------------------------------------
Best Regards,
John Xie
--------------------------------------------------------------
