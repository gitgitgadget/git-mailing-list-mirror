From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] commit: do not cleanup template
Date: Sun, 08 May 2011 10:38:28 +0200
Message-ID: <4DC65684.1050606@gmail.com>
References: <1304783624-9919-1-git-send-email-billiob@gmail.com> <7vwri2uv4m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Boris Faure <billiob@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 10:38:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIzVv-0001Jy-13
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 10:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555Ab1EHIih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 04:38:37 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39696 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab1EHIig (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 04:38:36 -0400
Received: by fxm17 with SMTP id 17so3084348fxm.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 01:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=v3JzG0AnhJDFeFVHpUhKNFcfsAEEM3PrX8XCpEWGRyc=;
        b=h+a4oh/k7GTLaAE2Spl+ZNr/2J+NrRh8j/KrSn+/aoDdAIuXB8Xdvk8oAjxIP8UKLA
         C1yPYMU47mgw8n2NvIWJ8qD2iRR3fSa5ZRTnNNhjnW1BiN9mDt0spL2r0GBLgO9ojxVZ
         6i6OdszecOUttgNsMDg3a0wYqqok7WYURjHUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=xBYqCwkoShO9eb25a3QUb//sJoSUZjY9rokj22IcHOkMdF2INPq5DD4yb90iefvDjT
         F8ePysyf/kE65jIdqSCc7ra27INJslWCtUBZpHGzyFNaAGqQnVYPXauVkn/JfgRMKbNe
         Pdcv0ZkIcmbfYlGm6n5EwZW2r8L8UzhmoJwX8=
Received: by 10.223.85.138 with SMTP id o10mr2278242fal.6.1304843912435;
        Sun, 08 May 2011 01:38:32 -0700 (PDT)
Received: from [192.168.178.23] (p5DDB0006.dip0.t-ipconnect.de [93.219.0.6])
        by mx.google.com with ESMTPS id 19sm1608961faf.29.2011.05.08.01.38.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 01:38:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vwri2uv4m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173079>

On 07.05.2011 22:13, Junio C Hamano wrote:

> My gut feeling is that it is relatively easy to justify [1/2]. We prepare
> the message file to be edited by the committer in sb by reading from
> different message sources, and usually we would want to clean up what is
> in sb before writing it out, but you may want to enforce a particular
> format by using the template (such as having a leading whitespace) and the
> way to tweak and fix that appearance should be by editing the template,
> not by automatically running stripspace() here [*1*] when the message came
> from the template.

FYI, Boris' patch pretty much matches the one I proposed back in [1] (or the slightly improved version in [2]). My commit message gives additional reasoning why whitespace in general should not be stripped from templates. IIRC, the only reason my patch was not accepted back then was that I was too lazy to write a test against it.

[1] http://kerneltrap.org/mailarchive/git/2010/3/10/25306
[2] http://repo.or.cz/w/git/mingw/4msysgit.git/commitdiff/39228f1b8af3eb6a6108c4fabf398d23a97a5993

-- 
Sebastian Schuberth
