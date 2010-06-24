From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/9] Add memory pool library
Date: Thu, 24 Jun 2010 20:43:55 +0200
Message-ID: <AANLkTilItX_xbbpX9mfKg0Dfx6ThzYuVsBu25C_-fJ6W@mail.gmail.com>
References: <20100624105004.GA12336@burratino> <20100624105339.GC12376@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 20:44:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORrPS-0007Ti-LW
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 20:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785Ab0FXSoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 14:44:17 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55856 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab0FXSoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 14:44:16 -0400
Received: by gye5 with SMTP id 5so4585002gye.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=ImO+Bo5Co9l26k3GexPIq5dQw7IJRRrd0spmOjHt9xM=;
        b=sKTPbp7Vu3Q2w0kva5tH+dWM6NE5+G3JUSAJI5YCqLYXT/oQR8le0xNA5pzzJxmc1E
         66gDGTyUdjdHKX5pbJcwv5ZI1jgdjA/D8zApNG0rDcEc8e8NdoIcCzrnD9iy8w47hm+G
         PqYiOkNekB1INfLXYh6MW6d7EbhLlFYujawuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=SynEIkm+azoNagnRD0UqYfWWWHZZt9AAIdp7deeFI05QdsVaZQ2QRdNoGsCC0qppP5
         YdxDRFhgAGkFQWARo/TkSOS8V3jQmcPPhJUl+ywRySN0+85AXlkB/4Pj7MCmsxdOAnGb
         DRX40z3tk3pNBt5QIQRCsVkYByfI+6n+h/iB8=
Received: by 10.229.182.131 with SMTP id cc3mr5676671qcb.53.1277405055213; 
	Thu, 24 Jun 2010 11:44:15 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Thu, 24 Jun 2010 11:43:55 -0700 (PDT)
In-Reply-To: <20100624105339.GC12376@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149619>

Hi Jonathan,

Jonathan Nieder wrote:
> From: David Barr <david.barr@cordelta.com>
>
> Add a memory pool library implemented using C macros. The obj_pool_gen()
> macro creates a type-specific memory pool API.

Until some sort of mmap is implemented, I doubt we can do much better
than this. By marking all the generated functions MAYBE_UNUSED, we're
actually suppressing more warnings than intended. Maybe we can avoid
it and somehow find a way to mark only those functions that are really
unused? Perhaps an extra parameter in obj_pool_gen?

-- Ram
