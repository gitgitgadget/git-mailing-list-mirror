From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 1/4] replace: add --graft option
Date: Sun, 8 Jun 2014 08:49:45 +0200
Message-ID: <CAP8UFD344NFECqtO-uK-2wHA7XEko3XMJWuhW9+KGBdaiqGq+w@mail.gmail.com>
References: <20140604194118.23903.3019.chriscool@tuxfamily.org>
	<20140604194353.23903.89933.chriscool@tuxfamily.org>
	<xmqqfvjjrpq9.fsf@gitster.dls.corp.google.com>
	<CAP8UFD3k98_6Uh+noJgt4xqEooATVMAEf58FFkuy6rHBnP10zw@mail.gmail.com>
	<CAP8UFD2u-DReCv2ZXhAzH_UMW5P--+a=AKS-N88xE6zmdWBLqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 08:51:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtWxK-0005GQ-4e
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jun 2014 08:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbaFHGtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2014 02:49:46 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:40202 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985AbaFHGtq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2014 02:49:46 -0400
Received: by mail-ve0-f174.google.com with SMTP id us18so3121509veb.33
        for <git@vger.kernel.org>; Sat, 07 Jun 2014 23:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AP7+uNHP8INlCuGJb7X+8BrZ8u+cH/et+DZmoP8Dpdg=;
        b=gElaMfHCCukIuqWUz3Vf5cDGO0WELT8tHEvKSZZK+gLZjwKpH8Zz9TFthiPlVPfsFz
         P55qtczOWHjuJ0DUxIAvlQOYxU6I/UoVkAa6lvx0Bzq1TFB6OvOa5OpaKziQp6BwCdur
         VVg4rCTfNhQIhHSaUY49BnEtjCNzfvc5Z3NoC9L9Zz4Y2bw3ag9BeIbyrMeRHcU5PrE2
         TJP2GRceV5xhR31Zg5Pv8cmsoPST3nBy1JehV6HigVI2Yii+CzQQ0c69Amw2G1jDCn8m
         al4FPltfbwovB+6ofl6UBqIuzmDoKVXCxX3+dH8rLC509Seaxi/noKE9be8s0GevRnFX
         B7uA==
X-Received: by 10.52.135.226 with SMTP id pv2mr14812949vdb.33.1402210185116;
 Sat, 07 Jun 2014 23:49:45 -0700 (PDT)
Received: by 10.58.134.107 with HTTP; Sat, 7 Jun 2014 23:49:45 -0700 (PDT)
In-Reply-To: <CAP8UFD2u-DReCv2ZXhAzH_UMW5P--+a=AKS-N88xE6zmdWBLqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251048>

On Fri, Jun 6, 2014 at 5:44 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>
>         /* find existing parents */
>         strbuf_addstr(&buf, commit->buffer);

Unfortunately, it looks like the above will not work if the commit->buffer
contains an embedded NUL. I wonder if it is a real problem or not.
