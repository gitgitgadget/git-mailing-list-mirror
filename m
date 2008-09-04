From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Monotone-devel] Re: [RFC] mtn to git conversion script
Date: Thu, 04 Sep 2008 03:31:52 -0700 (PDT)
Message-ID: <m3vdxcp5gv.fsf@localhost.localdomain>
References: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com>
	<20080824131405.GJ23800@genesis.frugalware.org>
	<94a0d4530808241133n5cc9f17arc79a1a5013187869@mail.gmail.com>
	<20080824224658.GA16590@spearce.org>
	<94a0d4530808241745r3f2bdb56q9cfa8bc61f79223e@mail.gmail.com>
	<g95eoo$5ok$8@ger.gmane.org>
	<94a0d4530808280203o6d97f69we4768115e12800c2@mail.gmail.com>
	<94a0d4530809040243k49635fd3kfef1ee22a6865e98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Anand Kumria" <wildfire@progsoc.org>, monotone-devel@nongnu.org,
	git@vger.kernel.org
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 12:35:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbC9A-00022i-5M
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 12:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbYIDKbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 06:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbYIDKbz
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 06:31:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:58368 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbYIDKby (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 06:31:54 -0400
Received: by fg-out-1718.google.com with SMTP id 19so390026fgg.17
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 03:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=ad+9Z4R+4xDgxKB0mt98OGDUjk6ADp2UDiwaGzgYRfE=;
        b=u3uNNmrh5qcUoTUV/u63ijJu4t6H4BAebSRmNLFO3yQhc/WRY8/Gcggu+vTrSnnGqh
         nGZW/heqyX0yZoCiOFdYl9cZt2w8T0xSG8RgGIP0XJbDye9QGQcyeIJpB62vvtuJIBeQ
         GqSU/leYAmoGh+sExPyGeVsxTugaWGz7CtkXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=bVqq6tjVh1vY1yuQefmuwRm4IgxNKVoI1szlOgWgQE/9Y3Qc0ke3UY7eXO+2ZvYyBR
         SYsYE4ySzn+MblsHLucTVC+rV4bQOi3E8AX5nJp12sT5BGRDebtA1c88y5TumL4X3BU+
         oCpVEsiEJPMkXzpZYggSgjFUHCIRs4L85Pbw0=
Received: by 10.86.74.15 with SMTP id w15mr7552358fga.42.1220524313408;
        Thu, 04 Sep 2008 03:31:53 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.201.254])
        by mx.google.com with ESMTPS id 4sm11152809fge.8.2008.09.04.03.31.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Sep 2008 03:31:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m84AVnbW015685;
	Thu, 4 Sep 2008 12:31:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m84AVj5r015682;
	Thu, 4 Sep 2008 12:31:45 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <94a0d4530809040243k49635fd3kfef1ee22a6865e98@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94921>

"Felipe Contreras" <felipe.contreras@gmail.com> writes:

> Ok, now the basics seem to be working. So I'm uploading some code if
> anyone wants to take a look.
> 
> The C code is generating a topologically sorted list of revisions, and
> storing the relevant information (certs and parents) separately. This
> code is very fast. It's using GLib and sqlite3, so probably the GLib
> stuff should be converted to use libgit.
> http://gist.github.com/8742
> 
> The Ruby code takes that input and generates an output suitable for
> fast-import. It would be tedious to port the parsing stuff to C, but
> straightforward.
> http://gist.github.com/8740
> 
> A patch for fast-import is required, I already submitted it.
> 
> Comments?

If you feel like it is good enough, could you add information about
this tool to Git Wiki:
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
in the "Interaction with other Revision Control Systems" section?

TIA
-- 
Jakub Narebski
Poland
ShadeHawk on #git
