From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 0/6] git-p4 tests, filetypes, shell metacharacters
Date: Sat, 15 Oct 2011 21:00:12 +0100
Message-ID: <4E99E64C.9@diamand.org>
References: <20111015155358.GA29436@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Chris Li <git@chrisli.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Oct 15 22:01:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFAQL-00019s-Er
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 22:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806Ab1JOUAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 16:00:16 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42449 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab1JOUAP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 16:00:15 -0400
Received: by wwe6 with SMTP id 6so426485wwe.1
        for <git@vger.kernel.org>; Sat, 15 Oct 2011 13:00:13 -0700 (PDT)
Received: by 10.227.38.200 with SMTP id c8mr4524415wbe.101.1318708813827;
        Sat, 15 Oct 2011 13:00:13 -0700 (PDT)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id e7sm21600182wbh.12.2011.10.15.13.00.11
        (version=SSLv3 cipher=OTHER);
        Sat, 15 Oct 2011 13:00:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20111015155358.GA29436@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183673>

On 15/10/11 16:53, Pete Wyckoff wrote:
> This series of six patches has been reviewed on the mailing list
> and should be ready for inclusion.
>
> 1    - Clean up git-p4 tests, including Junio review comments
>
> 2..4 - Handle p4 filetypes better, including Chris's suggested
>         utf16 fix
>
> 5    - Fix p4 keyword parsing
>
> 6    - From Luke: avoid using the shell, so filenames with metacharacters
>         are not errantly expanded

I've just tried running the tests in parallel (master branch) and it 
works a treat.

You've also tidied up my earlier test cases very nicely.

There doesn't seem to be any way to cope with multiple instances of the 
same test running at the same time. If p4d could write its pid somewhere 
then something better could be done, but it doesn't.

Ack.

Thanks
Luke


>
> Luke Diamand (1):
>        git-p4: handle files with shell metacharacters
>
> Pete Wyckoff (5):
>        git-p4 tests: refactor and cleanup
>        git-p4: handle utf16 filetype properly
>        git-p4: recognize all p4 filetypes
>        git-p4: stop ignoring apple filetype
>        git-p4: keyword flattening fixes
>
>   contrib/fast-import/git-p4     |  287 +++++++++++++-------
>   t/lib-git-p4.sh                |   74 +++++
>   t/t9800-git-p4.sh              |  574 ++++++++++++++++++----------------------
>   t/t9801-git-p4-branch.sh       |  233 ++++++++++++++++
>   t/t9802-git-p4-filetype.sh     |  108 ++++++++
>   t/t9803-git-shell-metachars.sh |   64 +++++
>   6 files changed, 918 insertions(+), 422 deletions(-)
>   create mode 100644 t/lib-git-p4.sh
>   create mode 100755 t/t9801-git-p4-branch.sh
>   create mode 100755 t/t9802-git-p4-filetype.sh
>   create mode 100755 t/t9803-git-shell-metachars.sh
