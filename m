From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] incorrect search result returned when using git log with a
 future date parameter
Date: Wed, 30 Jan 2013 14:15:44 -0800
Message-ID: <20130130221544.GA15680@google.com>
References: <51090466.9070105@casparzhang.com>
 <7vsj5ijvei.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Caspar Zhang <caspar@casparzhang.com>, git@vger.kernel.org,
	Gris Ge <fge@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 23:16:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0fx1-0006mW-Ts
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 23:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115Ab3A3WPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 17:15:53 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:54348 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755985Ab3A3WPx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 17:15:53 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so967666dak.6
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 14:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=vtceZqvhZ3cldF0yww2xrifiN+r7zEgAxZqT1UthyZE=;
        b=b2Sl5WB8NoToIbB5Jw8Z5GtehGC7c0Zv81Cc2OF9it1FghZBiK/bilUKPwiD3ggXct
         CDun9EXhYQEipLg+qXkq38cacSjumkksMrQeRcm+23X1GnKmj7WoMQU/eOEKdlAJuguu
         WQeAZBgzZ4XqSjSto0hCBuejAg7N9tRRM86w8HCQw3uNw5zT8M2RJ0k21yqz7M8V3dhS
         2YcYWnEgSk/4YnUmDZcYY/JYkGy2r80aZvKZh0ygCOnFuJt1dyPfnUxd4umkgbnl1Cuy
         iLJhTrXXy/FtlckieJCMyDLXjAI7Mcn18kvfg06YCPk/u2yJwsdTM/BKz3rm0NNGV7+N
         yC3A==
X-Received: by 10.68.219.138 with SMTP id po10mr16142089pbc.103.1359584152440;
        Wed, 30 Jan 2013 14:15:52 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id qh4sm2762703pbb.9.2013.01.30.14.15.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 14:15:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vsj5ijvei.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215076>

Junio C Hamano wrote:

> When it is fed 2013-02-12, it is ambiguous and "approxidate" can and
> should use whatever heuristics (including rejection of future) to
> guess what the user wanted, but 2013-02-13 cannot be interpreted in
> any other way, so we should parse it as such.

FWIW, if you said 02/12/2013, I'd agree, but I've never seen someone
using 2013-02-12 to mean December 2.

So that suggests another possible tweak on top. :)

Thanks,
Jonathan
