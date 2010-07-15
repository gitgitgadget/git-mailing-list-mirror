From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/8] Export parse_date_basic() to convert a date string
 to timestamp
Date: Thu, 15 Jul 2010 12:25:06 -0500
Message-ID: <20100715172506.GA23989@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <1279210984-31604-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 19:26:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZSCO-0005KD-Pj
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 19:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933908Ab0GOR0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 13:26:08 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37507 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933810Ab0GOR0G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 13:26:06 -0400
Received: by qwh6 with SMTP id 6so289946qwh.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 10:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CN9YHYy0pyP8R5ZY7OlIk36ZYRhnwJLhI5CNl3IEDYg=;
        b=fpEFOHBdcYj62z2afgkPutSfGrF8MCeauY+gwhz6vZx5OkvKaFjZhZ9UfezjRK1eqs
         hHlwaJId5L4OKg1cJ/FMD+pqaihi3bBzsDkUgnODyBikM5+LTAMK8NrS/dHUdsXreiK2
         7mHPy5jV2GyxcaAHb7TydMTMzfjYy2PZSu6xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OHrcC0x+y6rL03/tTYSwzXObIqKw3lvninG06/MzFId/Eeiuk9sPysLeULuYDvtFB6
         ygpBKQGXX1Qt3g9LX4otWGV4wCzdKMMbPk8gghsX0HKQnlN6bcYMJFu+f0ttP2C5O5CW
         uPbOnQ8JelI84A+SmepLJJee02azPvlgYObIo=
Received: by 10.224.114.204 with SMTP id f12mr5338143qaq.150.1279214760364;
        Thu, 15 Jul 2010 10:26:00 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h41sm5613848qcz.1.2010.07.15.10.25.58
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 10:25:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279210984-31604-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151097>

Ramkumar Ramachandra wrote:

> approxidate() is not appropriate for reading machine-written dates
> because it guesses instead of erroring out on malformed dates.
> parse_date() is less convenient since it returns its output as a
> string.  So export the underlying function that writes a timestamp.
> 
> While at it, change the return value to match the usual convention:
> return 0 for success and -1 for failure.

Junio: I think this should be ejected from the series as an
independently useful cleanup.

Currently parse_date_toffset() is exported but not declared anywhere.
This patch gives it a more predictable API and adds a declaration.

Ram: thanks for the reminder.
