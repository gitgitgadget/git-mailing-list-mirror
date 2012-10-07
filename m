From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH] git-gui: Few issues with using full path name
Date: Sun, 07 Oct 2012 17:25:20 -0400
Message-ID: <5071F340.6030206@gmail.com>
References: <1349195115-15494-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 23:25:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKyLu-0001Ee-T7
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 23:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562Ab2JGVZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 17:25:25 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45465 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab2JGVZY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 17:25:24 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so7783435iea.19
        for <git@vger.kernel.org>; Sun, 07 Oct 2012 14:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NK7lvJ07DUgK5K9BQDr9o6y9XyBF1BUrqYV2nmmTW6Y=;
        b=buK1j71CbkR6eCLzNgp/Um5Ida3YILcpRUiIkoPis2yAO/p1W3Owjn0oPZi6iM6L0r
         cyTOd/S5weOrhPhDQosbOG4pTHsqr3I9ddvkbpsDWNTfA/higWmbuWppSbSclZVijxPR
         Wlu0vwQ7qZ++3V+gawPBUZzjKSoQMK7d2TDBjQqwlVbT8GNE20RVmKwSST7CIpOLnBNJ
         7DEmrPDP8QUE28mQ72s/SZGrTf4xx1aO6CG4bYnX6stpqu3a2TunkB2aKvZtepMfP/H7
         gtI59gya2AxlDtbfc6yTR7YLYGIlf/05tUysZZTKUJEvum6uPi8KXnqoiXekPNKOJwcj
         0wLA==
Received: by 10.42.57.10 with SMTP id b10mr6917706ich.54.1349645123621;
        Sun, 07 Oct 2012 14:25:23 -0700 (PDT)
Received: from [192.168.1.3] ([69.165.255.59])
        by mx.google.com with ESMTPS id 7sm5672405igh.0.2012.10.07.14.25.21
        (version=SSLv3 cipher=OTHER);
        Sun, 07 Oct 2012 14:25:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20121007 Thunderbird/10.0.7
In-Reply-To: <1349195115-15494-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207200>

Could we look into getting these two patches into git/git-gui?

On 10/02/12 12:25, Andrew Wong wrote:
> I ran into a file name parsing issue in git-gui. If I'm in a subfolder and try
> to pass a full path to "git-gui blame", then "git-gui" will fail to detect the
> argument as a valid path. The first patch will handle this scenario.
>
> The second patch just another issue that I noticed when "git-gui" fails to
> detect the file name. It'll then try to use the previously detected "head" as
> the file name, while prepending it with "prefix". This is incorrect if "head"
> is actually a full path.
>
> There is also an issue when using a full path along with a rev argument, but I
> don't have time to look it right now. I'll try to get to that issue another
> time.
>
> Andrew Wong (2):
>   git-gui: Detect full path when parsing arguments
>   git-gui: Don't prepend the prefix if value looks like a full path
>
>  git-gui.sh | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
