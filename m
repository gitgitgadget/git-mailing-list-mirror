From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: From 200 to 404 to 407.
Date: Wed, 28 Oct 2009 12:48:47 -0400
Message-ID: <32541b130910280948u57535c2bnbc30424b7ef13e2a@mail.gmail.com>
References: <82fd2c5d0910270318wc30bc44tfd3362933d3f62cf@mail.gmail.com> 
	<32541b130910270953w6bd35ddctd471e682830b8f62@mail.gmail.com> 
	<82fd2c5d0910280138r52baff98p3f4ff65e968b0d37@mail.gmail.com> 
	<32541b130910280850t5b4baa91p90b31b4c1c467e94@mail.gmail.com> 
	<loom.20091028T170227-957@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Peter_Od=E9us?= <peter.odeus@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 17:49:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Bhz-0000wi-9p
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 17:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972AbZJ1QtE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 12:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754866AbZJ1QtD
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 12:49:03 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:50512 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761AbZJ1QtC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2009 12:49:02 -0400
Received: by ywh40 with SMTP id 40so814757ywh.33
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5K1rlkZl0j8t/dttSb8blhC6RSkA8DJsgXW8x36Ql6w=;
        b=lKmWmq8INLR7yAyo2UbScFnHNzohJI7SQAlVfGNO0YqMYKlTxuFnIPxqNckv8Vy8PN
         NW9VNVHoY9U3wyPMYUGEcJkbs9MLFxKLy7KCJmcs/v/Bb1/kQHHEGwfZojGC82LvcV0n
         8Tup6LUKpDVoUiOyQIu4qKQVQXW8P8W8Bb0Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qHNNze2TwDR+eVIJNhFm0rovdNLvY2dwl2cqDnLG0Vkf1eqAD8uBEord6ynp1//hkt
         z3v7bTK4w9bUYhT687qIKoww1mhJmg7f16WeKhO1m0aTCY+BzQ++hgfE5VSqgT1WAGQR
         C0gvkO1t6y8FeX4nv1lSqtL8BoEfUra113rmw=
Received: by 10.150.235.17 with SMTP id i17mr18067814ybh.200.1256748547115; 
	Wed, 28 Oct 2009 09:49:07 -0700 (PDT)
In-Reply-To: <loom.20091028T170227-957@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131480>

On Wed, Oct 28, 2009 at 12:10 PM, Peter Od=E9us <peter.odeus@gmail.com>=
 wrote:
> Anyway. Behind these corporate walls, the proxy is a reality to deal =
with, so
> hopefully someone else can bring us closer to a solutiuon.

I was just looking at the source and it seems all the curl-related
stuff is isolated in git/http.c, and is pretty easy to understand.
Since I have no way to reproduce your problem, I won't attempt to look
into it myself.  But if you look for "proxy" (and especially
CURLOPT_PROXY) in that file, you might find something.

Specifically, I would suggest resetting the CURLOPT_PROXY setting
before each URL request (eg. in new_http_object_request).

Hope this helps.

Avery
