From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] urlmatch.c: recompute ptr after
 append_normalized_escapes
Date: Thu, 12 Sep 2013 15:05:05 -0700
Message-ID: <20130912220505.GM4326@google.com>
References: <75d702a744eb33a456622dd2ff901abef83e51d8.1378979451.git.trast@inf.ethz.ch>
 <c8915eaaf877abe0e69864ffdc6c50f@f74d39fa044aa309eaea14b9f57fe79>
 <xmqqioy5q4dd.fsf@gitster.dls.corp.google.com>
 <85CEBFAA-8905-46EC-88C5-5DDE629B73F9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 00:05:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKF0l-0006vw-Dy
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 00:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab3ILWFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 18:05:11 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:59381 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab3ILWFK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 18:05:10 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so1680878pad.18
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 15:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=K6JR6aLDyf/87A6cEtIPfnUrrGDqo3VLjasTp0Co2Ew=;
        b=Fa92T7YYCsPjFTo6MDUNj2HA2O9cfdlEXD6ub3y0TcpR+Didrp1DxFPaBAj8BymIaf
         J7c7g2Ozkbt2PO8aUFBcpD5ny5+KiZQk7o4Mk9KnL50tusbXyRvaMg/ujCOj/rDZG9v/
         FGBccKq2xxsFFPjf50WiRzDT6UV3PP4rFVMGehJmbXLr53JdLnvvaYFXjtAnVx8XySrB
         h5kRUSXmXns7AnnxzheHLIbQ6LSM7rsi5ffJfumNTcIl1QCXIfjHcCg+4CRCL/4Ut1l+
         94UGG9+Z/lFSswWFvUVMkkbfT++8dxt3g5YAtiPDrqwS1WXdbQ7kwI2Ek2v+IB2YO8xl
         J4ow==
X-Received: by 10.67.3.103 with SMTP id bv7mr11645322pad.15.1379023509716;
        Thu, 12 Sep 2013 15:05:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xv2sm1086595pbb.39.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 15:05:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <85CEBFAA-8905-46EC-88C5-5DDE629B73F9@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234703>

Kyle J. McKay wrote:

> The longer comment looks good to me.  If you think the code will be safe from
> simplification patches without a comment, that works for me too.

I think if we can't trust reviewers to catch this kind of thing, we're
in trouble (i.e., moving too fast). :)

So FWIW my instinct is to leave the comment out, since I actually find
it more readable that way (otherwise I would wonder, "Why am I being
told that a strbuf's buffer has a nonconstant address?  Do some other
strbufs have a constant address or something?")

Thanks,
Jonathan
