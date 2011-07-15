From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/3] fast-export: use object to uint32 map instead of "decorate"
Date: Fri, 15 Jul 2011 11:40:02 +0200
Message-ID: <CAGdFq_guf8fa014t17KyNoEzpCAK-aG5BrpQ40tQ=1507OJ8bw@mail.gmail.com>
References: <20110714173454.GA21657@sigill.intra.peff.net> <20110714175211.GB21771@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, "Ted Ts'o" <tytso@mit.edu>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 15 11:40:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhet9-0000IQ-H1
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 11:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965400Ab1GOJkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 05:40:43 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61715 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965262Ab1GOJkm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 05:40:42 -0400
Received: by pzk3 with SMTP id 3so1347409pzk.5
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 02:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Q8dMKeheHj+mmiDXeIMcwhjX9WLQEwgM3paX9mKFCIY=;
        b=NOnYg3RxcaRfqhn1vOcvcZO4rkObnQ1pt3jZBv3DBtHs8Qj5BzpHnSU8c82DmA4kTB
         xY2fTZHrO9xe8ELt9uwvseFZ969+h994gD1lngX/14H68vNfwm9vOgdqOIHGqdU+Ux+c
         q++HSJs+fF+Ap5KLIJV604S1bxaNTMLnZ9UdI=
Received: by 10.68.27.232 with SMTP id w8mr3713411pbg.49.1310722842194; Fri,
 15 Jul 2011 02:40:42 -0700 (PDT)
Received: by 10.68.49.39 with HTTP; Fri, 15 Jul 2011 02:40:02 -0700 (PDT)
In-Reply-To: <20110714175211.GB21771@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177196>

Heya,

On Thu, Jul 14, 2011 at 19:52, Jeff King <peff@peff.net> wrote:
> Previously we encoded the "mark" mapping inside the "void *"
> field of a "struct decorate". It's a little more natural for
> us to do so using a data structure made for holding actual
> values.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> And this is an example of use. It doesn't save all that much code, but I
> think it's a little more natural. It can also save some bytes of the hash
> value in each entry if your pointers are larger than 32-bit.

Did you run any benchmarks on this?

-- 
Cheers,

Sverre Rabbelier
