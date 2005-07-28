From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: [PATCH] mmap error handling
Date: Thu, 28 Jul 2005 19:29:57 -0400
Message-ID: <118833cc05072816294f80a829@mail.gmail.com>
References: <1122586842.17837.9.camel@dv>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 29 01:30:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyHpr-0001pR-I9
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 01:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVG1XaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 19:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVG1XaG
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 19:30:06 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:44952 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262010AbVG1XaA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 19:30:00 -0400
Received: by rproxy.gmail.com with SMTP id r35so820750rna
        for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:29:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AORfpEUgDDHAn1M6ODb79DAfomBPlWflUcKEYYKfahK3FMLpWnaIofIiI3SA+Btuf6OBPFE0UMPEKx8fTXH4CzX25bN49GUuYMLpkGihgqWGtSxKmd/l1vW/Iu2zbF/L9m5q4kerZ6dd9lJUrZfwDRi1aYlcRV/vf9Bm28bXA/s=
Received: by 10.38.10.18 with SMTP id 18mr58448rnj;
        Thu, 28 Jul 2005 16:29:57 -0700 (PDT)
Received: by 10.38.76.22 with HTTP; Thu, 28 Jul 2005 16:29:57 -0700 (PDT)
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1122586842.17837.9.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> I have verified that successful close() after failed mmap() won't reset
> the output of perror() to "Success".

Does $standard guarantee that?

In general, successful libc calls can set errno to whatever they
please, except zero.  And they sometimes do.  This follows from
C99.

Morten
