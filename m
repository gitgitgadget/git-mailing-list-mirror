From: Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH] format_commit_message: honor `color=auto` for `%C(auto)`
Date: Tue, 24 May 2016 20:26:52 -0500
Message-ID: <20160525012652.GA13168@zoidberg>
References: <20160524194814.GA12479@zoidberg>
 <CAPc5daV4Z0gvaOL1H-v-G7RepGyiuir_AnzNx32aM3j2pm0RGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 03:27:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5NbB-0004sx-SG
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 03:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754514AbcEYB05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 21:26:57 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:36250 "EHLO
	mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbcEYB05 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 21:26:57 -0400
X-Greylist: delayed 20319 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 May 2016 21:26:57 EDT
Received: by mail-it0-f53.google.com with SMTP id e62so62883811ita.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 18:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gT/e3dZoDANMzj4H61WEMS7Tgg2ZwlRTNoudCpp+j/w=;
        b=NhfAzT8AQc3xFXm5hPOtFH5Yv31KUyne2x6DE9TLa9dbmw2uhCK3ki7Q7IgJtiTbIu
         GpnopVL67RwGtzM04uAaqujOyFzF98cAobU5M868ZP7W/fe9awbAnFPSpwJ61eZ6y3oH
         sisi6uRZtOJ+GRrixwkBMXAu3lDiKT4/DzoiCY7p24JOXx9FMxrVAZ/o9JkXO43jTVaO
         ZOqqSj8udUbozolV7z2y4WEU2g34NiIf1z0qVYR8ypBnKYRSbuMgbMV2iZ+Qfzz0eUSj
         lh4aDbaIgA8ONT5EKB4wFrJ/jVRgpiVW7xR8bL+CDfCLfqfyP45YIFStf1x3Gs3/uuDR
         QsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gT/e3dZoDANMzj4H61WEMS7Tgg2ZwlRTNoudCpp+j/w=;
        b=L0z1+UueNqNaAAn3iE3vwQLhA3q5D/w8tk8nHHRzOwqtkqX3Fv90aFQYYfwWt6wvht
         +V3kpacE7IwDaZfa9aEVzaiRRC7VSVEOj2W/ouTwkxgGosjCE5INmd4Et7eP5D47LRUV
         QikM+BwAncH9NfGRdL8OHT7ylClI86BZSa2HFfSvwSvmeaHL9mYWvRDdEil14Xoi+GxY
         NWDVOZgLuSKQ+nttqQmnPL++qnKbnQsFRypDyZMmuwywwbwhy9t4XJ1KRU7lePkNJ1UT
         i29zqaGhqLazd+Aie4U1e0UfJlX+OoUqerLV7ydUjPZIIVM1TZpwod0OYdol/DZcRTKM
         upPw==
X-Gm-Message-State: AOPr4FW0uuDiPxo9sTse1s/QLbGpfmPNTQQxpz8CWfESQSDoRGHkr2I5pMwe3RU7HE8cSQ==
X-Received: by 10.36.54.85 with SMTP id l82mr20757117itl.18.1464139616234;
        Tue, 24 May 2016 18:26:56 -0700 (PDT)
Received: from zoidberg ([2601:249:1000:6850:6d00:4a6d:6eb7:3a46])
        by smtp.gmail.com with ESMTPSA id d1sm6431950igv.5.2016.05.24.18.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 May 2016 18:26:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPc5daV4Z0gvaOL1H-v-G7RepGyiuir_AnzNx32aM3j2pm0RGw@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295550>

On Tue, May 24, 2016 at 05:55:02PM -0700, Junio C Hamano wrote:
> Looks obviously the right thing to do from a cursory read.
> Missing sign-off?

Yes, apologies for the oversight; will re-send.

Thanks-
-ed
