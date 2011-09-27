From: Luke Diamand <luke@diamand.org>
Subject: Re: [RFC/PATCHv2] git-p4: handle files with shell metacharacters
Date: Tue, 27 Sep 2011 10:32:46 +0100
Message-ID: <4E81983E.3070904@diamand.org>
References: <20110926214758.GB3433@arf.padd.com> <1317112836-14135-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pw@padd.com, vitor.hda@gmail.com
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 11:32:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8U25-0003Vm-8D
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 11:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab1I0Jcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 05:32:52 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43859 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab1I0Jcv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 05:32:51 -0400
Received: by bkbzt4 with SMTP id zt4so6702775bkb.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 02:32:50 -0700 (PDT)
Received: by 10.216.230.160 with SMTP id j32mr3157998weq.31.1317115969958;
        Tue, 27 Sep 2011 02:32:49 -0700 (PDT)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id fr18sm35070230wbb.9.2011.09.27.02.32.48
        (version=SSLv3 cipher=OTHER);
        Tue, 27 Sep 2011 02:32:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <1317112836-14135-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182226>

On 27/09/11 09:40, Luke Diamand wrote:
> Updated git-p4 changes incorporating Pete's comments.
>
>   - p4CmdList's stdin argument can now be a list.

- the only purpose of this is to avoid constructing large strings. I 
should probably submit as a separate patch.

>
>   - Getting rid of the string option entirely is very hard; there are
>     places where currently git-p4 creates a pipeline.
>
>   - I wonder if verbose should actually be enabled for all the test
>     cases?
>
>   - The $ENV{PWD} is needed now because the shell used to set that; now
>     that the shell isn't in use git-p4 has to set it.
>
> Pete - I wasn't sure whether you were saying I should rework
> my patch against next (and you would then rework your series) or
> something else. That sounds complicated though - let me know!
>
> Thanks!
> Luke
>
> Luke Diamand (1):
>    git-p4: handle files with shell metacharacters
>
>   contrib/fast-import/git-p4     |  200 ++++++++++++++++++++++++---------------
>   t/t9803-git-shell-metachars.sh |   70 ++++++++++++++
>   2 files changed, 193 insertions(+), 77 deletions(-)
>   create mode 100755 t/t9803-git-shell-metachars.sh
>
