From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Tue, 24 Sep 2013 14:31:16 -0700
Message-ID: <20130924213116.GQ9464@google.com>
References: <20130917201604.GA22008@redhat.com>
 <20130917201828.GC16860@sigill.intra.peff.net>
 <20130917203807.GA22059@redhat.com>
 <20130917205615.GA20178@sigill.intra.peff.net>
 <20130919213226.GA21291@redhat.com>
 <20130923210915.GA11202@redhat.com>
 <20130923213729.GE9464@google.com>
 <20130924055419.GA11208@redhat.com>
 <20130924193610.GO9464@google.com>
 <20130924201515.GB23319@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 23:31:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOaCb-0007qQ-Cs
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 23:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab3IXVbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 17:31:21 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:37340 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494Ab3IXVbU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 17:31:20 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so5146164pdj.4
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 14:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=58s4d9EcF21FCH2/g42jfxJqNwa1MM3S+kXRaTShfJg=;
        b=d8mx3Uf9c6E1k91OTDcltb4kG507cLkFehd1qr9Hhu7JNYH/pRqb7RrywIIbf81M73
         buDYWJEiowj+F1FgImbOcN1lqq49fPymEpNpfBTFuZaWskpuaGm52LRHK7KHzyK6tiNT
         eIw7J5REd5hlwn5x/MVEJAn7s0d0jzlgFJTWqJObSalRfEJIitG+y+bbL1ksr8xs97w3
         24lneAqtWD10xsraZ+LNgJWFG66Up1DUxeXH8ej4t1vYwhV47BGnlli8OqZ9m8QfyReN
         OXW9jDI+f6X14Qw7p0ykYj7gtY8L7ZchJWdVClgOQlzOGaGamJTXYNuxRtLF0HkKTrmS
         1Blw==
X-Received: by 10.66.250.138 with SMTP id zc10mr30803619pac.72.1380058280001;
        Tue, 24 Sep 2013 14:31:20 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ha10sm43046752pbc.23.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 14:31:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130924201515.GB23319@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235318>

Michael S. Tsirkin wrote:
>>> On Mon, Sep 23, 2013 at 02:37:29PM -0700, Jonathan Nieder wrote:

>>>>                       Then start over with sorted hunks (for example
>>>>     building a table of offsets within the patch for each hunk to
>>>>     support this).
[...]
> Well, then the result is not compatible with what
> original patch-id would produce.

Nope, I meant sorting to produce what the original patch-id would
produce for a diff with the default sorting order.  The result is a
patch-id that can be compared with patch-ids from earlier versions of
git as long as -O<orderfile> was not used (which was already not
compatible with reliable use of patch-id).

[...]
> Just making sure: is it correct that there's no requirement to use same
> algorithm between patch-ids.c and builtin/patch-id.c ?

I think so, as long as Documentation/git-cherry.txt is updated to stop
pretending 'git cherry' calls 'git patch-id' and the two get comments
about it, though it seems simpler to keep them roughly the same.
(They already differ in handling of binary files.)

Thanks,
Jonathan
