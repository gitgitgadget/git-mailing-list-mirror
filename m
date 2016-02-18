From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 2/3] config: add 'type' to config_source struct that identifies config type
Date: Thu, 18 Feb 2016 09:46:36 +0100
Message-ID: <46CB7F8C-2A0C-41E1-A6B7-C26448CAE052@gmail.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com> <1455531466-16617-3-git-send-email-larsxschneider@gmail.com> <alpine.DEB.2.20.1602171412080.6516@virtualbox>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, peff@peff.net, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 18 09:46:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWKEY-0000Ab-LV
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 09:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425627AbcBRIqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 03:46:42 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37500 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424633AbcBRIqk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2016 03:46:40 -0500
Received: by mail-wm0-f51.google.com with SMTP id g62so14566303wme.0
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 00:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1T2hR1yp+mPLHoRFeiH1IElz7IvSXciAvGAaaNU6qKo=;
        b=z6FBI6WdyPgMR5l+IjPV0/0Iw7ixr1Te3dZmWlG+T+1CDn7FGq7ar9A4Z6Khh0fXKW
         BaLtBGPpGMxjq9Pa1Ny+0nafwcygqkEgMoRlgJZhI60FlRVYBCIv18Fzrin69NKbYK/q
         9sEP+ujD7Dlwm9HgeUfbEAKEvpWlC88NsQxGu9X6chUfatkowoo+Mm8TavxuHE6H9SuH
         RHQ6Fx2OFmraPsbqwfhABnEg8dlVFnFfbbislL8oqwxp8mo2Nq7mw6n+5kakdQbHpOTX
         QPbhKbSiswQ8cXeosNbunTEMU02X8JKKBV6iEY9Sro69uXnuQEVTyM50pXCTTLWqas+y
         V12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=1T2hR1yp+mPLHoRFeiH1IElz7IvSXciAvGAaaNU6qKo=;
        b=iOUkWibhgt7HMb9joT0X+0l33xO9V81SCY1K3B2ko2ei500z7i0R222m5VVA+4nr+K
         qk/eIG3aUxxwxPghAOGbc2+XFIfVC5U9GDAvbzV5k1Rq4wF6jkQof7n6LSdLkTVD1w4N
         DP80naDz9Nd0w68DP0fgBrHT/b/2SXuLq8PH5tkaNNi+EulQ9MjWJDpZxWmTnCSgR3+f
         UUdeBvQcYrnmrSijE5ab/P/rgM8SYvO7FJj7UwGGaSF0PBRseh/QpOO6Wtv2aEKfAD7G
         IWzITeccuNrDu/hiDPU8e0AqcJxhCU8aWX5CwztT+8wLH0ofsftyRbJy3OSIQ8gdWch5
         aq3g==
X-Gm-Message-State: AG10YORn9/0UdnbFcbdj6Yisr+/4fyMFqQ1mjR/9/3MNCDZa6+R4eCKKlKiwTLt34nSi0w==
X-Received: by 10.194.62.102 with SMTP id x6mr6381886wjr.18.1455785199702;
        Thu, 18 Feb 2016 00:46:39 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4227.dip0.t-ipconnect.de. [93.219.66.39])
        by smtp.gmail.com with ESMTPSA id g126sm1827590wmf.16.2016.02.18.00.46.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Feb 2016 00:46:39 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1602171412080.6516@virtualbox>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286602>


On 17 Feb 2016, at 14:12, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:

> Hi Lars,
> 
> On Mon, 15 Feb 2016, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Use the config type to print more detailed error messages that inform
>> the user about the origin of a config error (file, stdin, blob).
> 
> Given that you settled on `--show-origin` as the command-line option, I
> would have expected s/type/origin/g, too...

Agreed. Junio suggested "origin_type" which I like, too.

Thanks,
Lars