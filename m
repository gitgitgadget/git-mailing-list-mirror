From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git.c: fix help.autocorrect after 57ea712 breaks it
Date: Wed, 27 Jan 2016 16:14:52 +0700
Message-ID: <CACsJy8DzHYpw3TT3i17W-8eiR9J9DOQUO6mkxffUEnGqT1u96Q@mail.gmail.com>
References: <56A72235.9080602@drmicha.warpmail.net> <1453814801-1925-1-git-send-email-pclouds@gmail.com>
 <xmqq60ygcd9a.fsf@gitster.mtv.corp.google.com> <xmqqbn87a54v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 10:15:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOMCL-0002S0-9A
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 10:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166AbcA0JP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 04:15:28 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33858 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbcA0JPX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 04:15:23 -0500
Received: by mail-lf0-f49.google.com with SMTP id 17so1827895lfz.1
        for <git@vger.kernel.org>; Wed, 27 Jan 2016 01:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WgttwxhxyXOkLFnPacHr71TxbtJ3C6mahqYLqBoYm1s=;
        b=LiAz/gXOOHw0VC+Qd0ewiFeRHsc2CiwpnIEbWFqQniPf7bMJSew1gSjv8+aAUENF5W
         HP2MRxIqi0h/pWS9ThTuw/y6XZMWvMh8qBOgDVxLFwGATddNG38fuOkYHWo6at/sVh+B
         YYh0xuJ/tEtnZdsAsf90lnebzasXJ7JtzAK25LXFUmyIPjEtC9S14WAIp//90LbdoNdd
         1BTs14FCYf3dWcEa0WSmmKKMxfZo8oJ6THfnJ5OqP3QNjW1Me5Mvatgh4wFewZGZItSz
         +v49Tfhsb7bVVJBOOhwsOn1wpku75d0GUndakbckn9dPec/LjSG1bLWmwGrvXEi9gh7n
         mlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=WgttwxhxyXOkLFnPacHr71TxbtJ3C6mahqYLqBoYm1s=;
        b=fXeithAAUyXjfceHPF8hR9NQvpINwLpP/ZlkNObFc/KJBEBCepKD85dvSI7jIz4cir
         2OvpdZuFZcv/FKFE1a926PnkuXwezt4aFYUqohAPXGdPF/yvvdKKmiV1VwB8aaBrF61l
         vYYdScfgYkQovHpsZIqJg8sTO+brch8fpz1w+4PiVBjw0dXOIKRVapxmp/SoB+6yVBQG
         Ooq8C0J45YqyFcpWgv8uOb88sQ7wMmWzYcX3lg7nLukXM5ZGtDC2bN27f15P4mJlxd6W
         fPy4D4w09SdFyQUS3hwUFoqW/e/BhV5D5wSQL1BB1d1WuEAZND7GR/5n/X8mCSYTMD8Y
         aX8w==
X-Gm-Message-State: AG10YORWyUP15VVGzxxTZ9GrdbE69LwlyF2KN1N/J7AnMEZhziU3WPe0ifozeQFIGUA4kC4XcQa+E8Zy/6VdLA==
X-Received: by 10.25.17.229 with SMTP id 98mr8319093lfr.3.1453886121604; Wed,
 27 Jan 2016 01:15:21 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 27 Jan 2016 01:14:52 -0800 (PST)
In-Reply-To: <xmqqbn87a54v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284900>

On Wed, Jan 27, 2016 at 1:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I spoke too soon, I am afraid.
>> ...
>> I wonder if this would be better done as a multi-part series that
>> goes like this:
>> ...
>
> So here is the first of the three-patch series to replace it.

This is much better (the whole series, not just the first patch). We
probably should add a test about help.autocorrect though, maybe in the
first patch, because it's not tested at all in the test suite.
-- 
Duy
