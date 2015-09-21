From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v3] git-p4: use replacement character for non UTF-8 characters
 in paths
Date: Mon, 21 Sep 2015 20:34:53 +0100
Message-ID: <56005BDD.6050508@diamand.org>
References: <1442825358-90294-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 21:35:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze6rc-0008RN-1b
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 21:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbbIUTez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 15:34:55 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34553 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbbIUTey (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 15:34:54 -0400
Received: by wicfx3 with SMTP id fx3so161823242wic.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 12:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=vfy35XsDEqKZf0jf9BUDw0wzLwk+Z5jp48yq8986X10=;
        b=WhZAdLnv4efqb9HbI4eYFxKtylVhn9ctBSFujicfvUrvHgNvCEuQkfgKB2O4xdlftW
         YS5BjRPOTcIeV7OEI1FTDhAR7kzrJZ54n4T/f8i+3VYeWtQtMdGWyPP/+rr5OtMkXzf9
         sB21vhkGU2YFMb3YjWx1VgMAzoksT2vhz3j5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=vfy35XsDEqKZf0jf9BUDw0wzLwk+Z5jp48yq8986X10=;
        b=CSLpm7tYzhXB09DU3rHoB0LsYLGPTHJumFGUroeQXtcJBPfTxWvz08rJHzGApBwcEJ
         5hxyjdwE3CuaoMlkrrxXZ14gMs9hbhSff2WDp9ODzh+QK1ZOJLE9+RP2MQua/fhVrLJE
         f3XT1TQ+JQXbfzPr0ZQ1iRIYBvtvjYd50uCkBdg+5ZDRnbzBTg8qw/NGVJKRQA/7YfB5
         pYm+txOOV/jbutFBWdzrjkyqsrb6u2gy1wJuVSReT495mDhgRQLNITWQkvvPsUFsDova
         MKWhyYP+sZqiV2QGplGlNz5rjllPbBowZSomJ9PXlhuEZ64YbnZgey/0l8Sl4vJGLiGQ
         Gq5w==
X-Gm-Message-State: ALoCoQnxkywYz964B6zaIx7gTN38I7YPHlTQuLdAu9aYBAHO2hEnq8nxpDqRKE1r5C4uZoOZJTIG
X-Received: by 10.194.103.228 with SMTP id fz4mr24607316wjb.53.1442864093387;
        Mon, 21 Sep 2015 12:34:53 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id cm6sm15018656wib.22.2015.09.21.12.34.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2015 12:34:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1442825358-90294-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278325>

On 21/09/15 09:49, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> I broke a test in "[PATCH v2] git-p4: improve path encoding verbose output" on the next branch.
> This patch on top of next (3dd15c0) fixes the issue.
>
> Thanks to Luke for finding the issue!

Looks good to me, apart from using a UTF-8 char in the comment itself, 
which seems a bit unnecessary. Imagine what will happen to someone using 
git-p4 to mirror git-p4 itself into p4!


>
> Cheers,
> Lars
>
> Lars Schneider (1):
>    git-p4: use replacement character for non UTF-8 characters in paths
>
>   git-p4.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --
> 2.5.1
>
