From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 7/6 (v4)] support for commit grafts, slight change to 
	general mechanism
Date: Tue, 27 Oct 2009 14:11:21 -0700
Message-ID: <c77435a80910271411y5cb0e8d6u59be909b2a44c54a@mail.gmail.com>
References: <op.uzv4dyuotdk399@sirnot.private> <4ADCCCA9.4000802@gmail.com>
	 <200910211115.25017.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 27 22:11:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2tKC-0002OY-Al
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 22:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbZJ0VLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 17:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbZJ0VLR
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 17:11:17 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:48339 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349AbZJ0VLR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 17:11:17 -0400
Received: by ewy4 with SMTP id 4so148637ewy.37
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 14:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=8ImKOpIocymSGS5CVDnlR9YFE4ui7q3ibELo3KNyXmw=;
        b=NS2XtZOUHyBMmvcXKBVXp5Z2CZpzVq9RE82xo4JsLf/wj2z8XiMV2XaFva/Loq0qUq
         MGCiZA8eLvH83gbI1E9Ly3ynaipgwTA1NUeEmUJJ9MDkp9Zdqca1qkkvvCzdQJ4U8IgL
         rQvEY8rdV/M3iPbfw+vn4SO+uzGyNWLgazULo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bhAY22fBGK4kUGs4c2/DGGiGdZDHsKBp0OnDQshsqC3NwYkqMG38uLLi2L7hkO971X
         BdYo9tFqUXlm6lUiolx5RCfi0TqzVap9+gpmCID6B5c/UR30tTrCQFQCrmKWT3nN2CV1
         H22W3E1vxCY+KjN5bIpdWfRf/ZvS94wuMZYeg=
Received: by 10.216.88.136 with SMTP id a8mr3739610wef.77.1256677881125; Tue, 
	27 Oct 2009 14:11:21 -0700 (PDT)
In-Reply-To: <200910211115.25017.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131381>

> I felt adventurous and merged the topic into my local build, but I get
> "error: duplicate graft data ..." in repositories with only a single
> line in .git/info/grafts, which bisects to this commit (1c0a666 in
> today's pu).

Oops, it looks like there's a bug in my bugfix...  I had
parse_commit() accidentally calling itself through
register_commit_graft(); fixed now though.  Thanks for giving it a try
though!
