From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] commit-slab: declare functions "static inline"
Date: Sun, 1 Dec 2013 17:36:31 +0700
Message-ID: <CACsJy8CnxvPRwC_xXgBNF_JEmkpfnk=faMwOWtkJOFU-18aHgA@mail.gmail.com>
References: <cover.1385405977.git.tr@thomasrast.ch> <f4d1ff9f487f797da35faa86c72d11832903a50d.1385405977.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sun Dec 01 11:37:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vn4PC-00039s-45
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 11:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475Ab3LAKhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 05:37:03 -0500
Received: from mail-qe0-f41.google.com ([209.85.128.41]:40591 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab3LAKhC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 05:37:02 -0500
Received: by mail-qe0-f41.google.com with SMTP id gh4so9655910qeb.0
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 02:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iTW9wMYazxOYjy5jVDPb4fdy+7bV6WDdNI9bvB9YpJs=;
        b=kcIzxCtCoh7gSuJtKYZ4q2zoS95tJS7Pac8muR9dyXEjV6+e824/Uq9XD7S7fJl+aC
         yfX3H2Jf+p/mp91DOcSZ3JtHm/VWtVVU3eMdFIKPHNNpaZ1rt1TAYlbrPr738PYgR7Z5
         bzLb+71yVH21vQs59ooThChX6PWUtZwm30uEF0xzCQIJJJJKN1d1FcCW3TgyslOauPsi
         z7puTNicCXWym2tJEtuxZibJfHDR8HKSiDVgpHQ9IfLIwPrQI/oiUSeMPW7vzBTOEpuf
         dSOx3eI2648aGuUukd+W2HgPoU+4kJ4w6717nlc1T+bWrT/vw+gKjCNuLqHy0sdLLKua
         9PNA==
X-Received: by 10.49.105.138 with SMTP id gm10mr73283231qeb.7.1385894221440;
 Sun, 01 Dec 2013 02:37:01 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Sun, 1 Dec 2013 02:36:31 -0800 (PST)
In-Reply-To: <f4d1ff9f487f797da35faa86c72d11832903a50d.1385405977.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238584>

Thomas,

As you're touching this, perhaps you coud fix this line in slabname_at() too?

s->slab = xrealloc(s->slab, (nth_slab + 1) * sizeof(s->slab));

I think it should be sizeof(*s->slab), not sizeof(s->slab), even
though the end result is the same.
-- 
Duy
