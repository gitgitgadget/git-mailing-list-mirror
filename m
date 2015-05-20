From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v9 3/5] generate-cmdlist: parse common group commands
Date: Wed, 20 May 2015 12:32:20 -0700
Message-ID: <CAGZ79kYZJzM6Au2xCODFaReV=_LZ6HNi4=_24Gd5VWjpHjCB4Q@mail.gmail.com>
References: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com>
	<1432149781-24596-4-git-send-email-sebastien.guimmara@gmail.com>
	<555CE01F.806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 21:32:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv9jA-0007W5-Fa
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbbETTcX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 15:32:23 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35158 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955AbbETTcV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2015 15:32:21 -0400
Received: by qkdn188 with SMTP id n188so34056550qkd.2
        for <git@vger.kernel.org>; Wed, 20 May 2015 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XCI1NXml6V/eQ3tn4aZm6rJAxzofXlolO85+VvvKDOo=;
        b=cyodZFfxhR50y6TrgNjAhtMsyMOCYQ9aZ1uC6pJiHYBSGuF/nOktAhHSpb2KWgjjOl
         2SKD4FZzXiA9eQYht/OwkzeFe1C4CKR4QucsObHqN/z0MayJiQ3mo501Rl7RN+7DgvuA
         awxDn0tdu6AStG00MmPL94BAwoTUJHPCvMgfoYAKd01nEHOilUM5QBTLzsSfTamCyWB5
         n+QKkTvBBPRHMrKZ2MR+IHvJFtkIGtZHvlfRyoP6mZyYtfFpZhqkcC9g547MuZEEDGPw
         agQT5ye7jKDyxi9ilZBFIyiqMhnyYcOLmU1L1gdvHzIXiEmtQY3UB8BhlOR6c267TbGJ
         MYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XCI1NXml6V/eQ3tn4aZm6rJAxzofXlolO85+VvvKDOo=;
        b=Yt/4bOISCfHJviS6UopFIqle8TcgzS3RXENzvnq4iTmRwsMLMCgs9BIIZlE50XQJXT
         Ck5qsJxpxyFobv1kw9erOsE5pVHdg/I7m5jzpFEITPg0Tkxe2ZeH0nNHt/YQSo/9W4yb
         de5hfbZbOyUQO3QNsRHldKsHXmQXB7AUhL29el2EfQOELKmnQWBF0ZdjvB6RFUKBxTMN
         xbBHV1oZWLdLeQonsIsWAd5NKPrjYzft3Ts7OQJMxY3MmPWvrYjtoPuv248OdsVGjBvv
         hM+8kA+rRmBaFZi8jIHghv44bqBtQkbP0R6nh4khYKpS5xuWArHjt14chY+rLEGY1e6D
         Hoqw==
X-Gm-Message-State: ALoCoQk0jZ2XLinfmEBHq8437ABOSeKi4lm0buNs+mGhHUIicXq5P5n04J2hhiXaoRkLz4LvkJq+
X-Received: by 10.55.51.141 with SMTP id z135mr75414389qkz.84.1432150340200;
 Wed, 20 May 2015 12:32:20 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 20 May 2015 12:32:20 -0700 (PDT)
In-Reply-To: <555CE01F.806@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269505>

On Wed, May 20, 2015 at 12:27 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> On 05/20/2015 09:22 PM, S=C3=A9bastien Guimmara wrote:
>>
>> From: Eric Sunshine <sunshine@sunshineco.com>
>>
>
> It looks like 'git send-email' got confused with the CC field.
> I'm sorry for that.
>

It's to keep authorship.

When Junio picks it up, this will show as
authored by Eric, signed off by both of you (Eric+S=C3=A9bastien)
and committed by Junio.
