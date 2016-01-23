From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 02/11] update-index: use enum for untracked cache options
Date: Sat, 23 Jan 2016 12:02:01 +0100
Message-ID: <CAP8UFD3hcDqtZkwen+RJiHX-QKHpSpimzQxcb0+ujDL8XYU8gA@mail.gmail.com>
References: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
	<1453283984-8979-3-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8CeKdk4u6xppXFX0-k+9aP2BZZuiw5eqiZp=khBLbjjJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 12:02:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMvxZ-0000Jb-J5
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 12:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbcAWLCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2016 06:02:05 -0500
Received: from mail-lb0-f196.google.com ([209.85.217.196]:34378 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbcAWLCD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2016 06:02:03 -0500
Received: by mail-lb0-f196.google.com with SMTP id oe3so4697354lbb.1
        for <git@vger.kernel.org>; Sat, 23 Jan 2016 03:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tIlZ48jmraclp45wvssSfXq2lStoLjQYlEnI36QIl10=;
        b=vMpYxCg8Uz/jB4fbVtVD8xcbIzFtx3VmR+7ur0BWWMWF4b/9x6650/RkaFNMRyTKTx
         QTeilMFh45fLF71KMHNFDHkZ8por9718ggJ1sNDVoZzXpXvSaqg3pE9gi4b5WcSWTNRa
         8LQ3haISbzfYZ55rOjKJFFnbjbClTp1RtFBa7JJD6TqnUJL2ykMDdCJz4k/dzvzemJlj
         RuxvBD17AXwAvXAEQchBS/G2Sh9xXsk6ufjnp50vsEteFd5w1NRdlI9zZBEgBkqMFPEn
         lYB8j11FbBMjHw+LaDGjzq0svQCNWLOcg4tNizSV18UqDGDPr/nIqbzwWl8EP4LblaCo
         6jXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=tIlZ48jmraclp45wvssSfXq2lStoLjQYlEnI36QIl10=;
        b=QyaCtoIb/OshkHLvVvwWlttDdxa0ej4uJAibjBQnCnqFjoG7KYkktTdBcWWkBBXmTd
         cD3g0AJ9/yMDXYtuPC+fUAX0YWt/1HxhfzUxxaF3urKXx6u+1USXr+EW2S4lB70JMjCW
         lABwB9D7U9TJiOcGOpF9+ow/XTY6RQ406GXykpQUTKXZMq1seaRCNOuHKc5+Z2lOJKOd
         uTzDvMu+qziucqQiqN1FcJbNXGVPSGBvPyfYd+KkNvBKEh1rdHsNTD8K9GC73AMeqbpJ
         HL2whzI/xWkmSgNB+AiAnQn+blIWLJdyi3Gs1J1sGiaPrra282v5BmsbkFWW0RB40NOb
         kqcA==
X-Gm-Message-State: AG10YOQwZaYlWItbsaMhOJpaUs0xighCH4NJFKTiM7hM58twonrEY+VLgjAGty4NTBDlBJZGFyn5kvBomCX5+Q==
X-Received: by 10.112.211.168 with SMTP id nd8mr2919338lbc.116.1453546921337;
 Sat, 23 Jan 2016 03:02:01 -0800 (PST)
Received: by 10.25.216.143 with HTTP; Sat, 23 Jan 2016 03:02:01 -0800 (PST)
In-Reply-To: <CACsJy8CeKdk4u6xppXFX0-k+9aP2BZZuiw5eqiZp=khBLbjjJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284627>

On Sat, Jan 23, 2016 at 1:44 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Jan 20, 2016 at 4:59 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> Helped-by: Duy Nguyen <pclouds@gmail.com>
>
> Nit. I think usually your s-o-b comes last

Ok, I will resend a fixed version.

Thanks!
