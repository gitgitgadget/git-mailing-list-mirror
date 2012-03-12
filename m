From: Jonathan Nieder <jrnieder@gmail.com>
Subject: stripping [PATCH] without losing later tags from mailed patches (Re:
 [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 01:48:55 -0500
Message-ID: <20120312064855.GB16820@burratino>
References: <20120312002046.041448832@1wt.eu>
 <1331514446.3022.140.camel@deadeye>
 <20120312024948.GB4650@kroah.com>
 <20120312063027.GB8971@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>, Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Willy Tarreau <w@1wt.eu>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 07:49:26 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S6z4N-0001kr-Uh
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 07:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088Ab2CLGtO (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 02:49:14 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42063 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab2CLGtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 02:49:05 -0400
Received: by ghrr11 with SMTP id r11so2213996ghr.19
        for <multiple recipients>; Sun, 11 Mar 2012 23:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NbpSqm/zuY/JAb//2o/vb88o1/snXQyNOONexJCOwKg=;
        b=REx3gVPymBvyk3OriZFm2aij1yitmi+05YJR56OyA63nN2GS6iykkM5K150f6U+oQ4
         zkf/RBQttWgZTmAbq9p5ANvv0ot98D86WLXzzl6NFb3Rtrx6My1X1PAYutU5mu05OWPF
         XlvudlkJY3XujadBeKk6uGFdfIpV4d3Y2f/ocgJUl/rDee6J4jpys/ZV5tZ9eQIZjpM/
         Jz6h/M3Sz7T4jgIYgE/B150+hnOW35NNX0Uxfwfg6FXjh7CEpLPaQXyEAOsFsuWa5h8Z
         a0iYIV5d7FGDLvid9NWBrBNfYerHVOuopweUzbrvCRdWzhKOCcREGIaPK3jNggYq89SI
         uzpw==
Received: by 10.60.5.193 with SMTP id u1mr6324356oeu.8.1331534944931;
        Sun, 11 Mar 2012 23:49:04 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q5sm9832592oef.3.2012.03.11.23.49.03
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Mar 2012 23:49:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120312063027.GB8971@1wt.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192843>

Hi,

(adding git list and Thomas to cc)
Willy Tarreau wrote:
> On Sun, Mar 11, 2012 at 07:49:48PM -0700, Greg KH wrote:
>> On Mon, Mar 12, 2012 at 01:07:26AM +0000, Ben Hutchings wrote:

>>> The subject/first line should include '[IA64]', as in the original
>>> commit.  It looks like this has been automatically stripped.
>>
>> Yeah, munging patches to and from quilt and git will cause that to
>> happen at times, it's quite common :(
>
> Indeed, and I've even changed my patch formats in haproxy to avoid brackets
> due to this issue. The cause is that many patches are sent with a [PATCH]
> prefix and that with Git, either you keep the subject line intact or you
> remove everything that is between brackets. There's the -b option to only
> remove remove tags looking like [PATCH], but my general experience with it
> was not satisfying (I don't remind why).

Maybe the problem was as simple as "git am" not knowing about "-b".

Two relevant patches:

  f7e5ea17 (am: learn passing -b to mailinfo, 2012-01-16)
  ee2d1cb4 (mailinfo: with -b, keep space after [foo], 2012-01-16)

are in "master" and 1.7.10-rc0 and were not part of any earlier release.

Kudos to Thomas for writing them.

Jonathan
