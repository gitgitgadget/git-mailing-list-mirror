From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [msysGit] Pull request for msysGit patches
Date: Wed, 29 Sep 2010 00:17:34 -0400
Message-ID: <4CA2BDDE.6040100@sunshineco.com>
References: <87ocbitd33.fsf@fox.patthoyts.tk> <201009282252.25688.j6t@kdbg.org> <4CA2A32E.3050802@sunshineco.com> <7vfwwtrzi7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 06:17:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0o6z-0006jm-Hd
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 06:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087Ab0I2ERj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 00:17:39 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65363 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab0I2ERi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 00:17:38 -0400
Received: by gye5 with SMTP id 5so55977gye.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 21:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=dOux2t3/22DSk21s7vZhJiR6yedNpxg0PabZgcKHwYE=;
        b=RUwSWt3xsh6EKzN+2ME2Bp/tdjOJO/Sdgm00rXbmnbgvURzPiVTCKiZ54pBk0l8OFf
         KosiKsPZNpYUY/+8Y12jNIj3ZovacWflOooKShnFZcwqRptFfqDdkIcOraPAJzQyb/FT
         L7Us/c3WQ0hM5ycywRFQ4/GB6WG19GAZFtOZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=sdj8LGX8MJCvwkFSDNZhsGHxB/Io8N39zMfNIX+98Tuh8sCDr25wvExFgXCtjnOSc3
         QVDCLhlbR6PRSXU0aA3AQf4y2o6ZhtE/rlbtUD6eb8SkUFHOtVG2H+ntPrd2GuubEsnL
         XAN/6hMWmdXBg3prqiY5hCJP+2ofNVtdzfDS0=
Received: by 10.100.138.6 with SMTP id l6mr1104618and.192.1285733857856;
        Tue, 28 Sep 2010 21:17:37 -0700 (PDT)
Received: from [192.168.1.1] (user-12l2cil.cable.mindspring.com [69.81.50.85])
        by mx.google.com with ESMTPS id w1sm9397853ana.16.2010.09.28.21.17.35
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 21:17:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <7vfwwtrzi7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157525>

On 9/28/2010 11:37 PM, Junio C Hamano wrote:
> Eric Sunshine<sunshine@sunshineco.com>  writes:
>> I also normally avoid unportable 'export foo=bar'. In the particular
>> case of GREP_OPTIONS, when commenting on my original patch submission,
>> Dscho suggested 'test_have_prereq MINGW&&  export GREP_OPTIONS=foo' so
>> that is the form which made it into the final patch.
>
> Well, since bbc09c2 (grep: rip out support for external grep, 2010-01-12)
> we do not run external grep at all, so GREP_OPTIONS is irrelevant.
>
> Unless you are planning to run tests on installed version of git older
> than v1.7.0, that is ;-).

The patches in question involve test scripts which themselves invoke 
external grep for various reasons. An example is t5560 where external 
grep is invoked to extract the Status: header from an HTTP response. The 
patches fix instances where grep invocations give incorrect results on 
Windows due to grep undesirably swallowing CR from CRLF line-terminators 
in the few tests where those terminators are actually significant (such 
as t5560). In the context of these test scripts, external grep is still 
employed, so GREP_OPTIONS may still be relevant.

-- ES
