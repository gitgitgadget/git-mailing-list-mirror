From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] Use %as and %cs as pretty format flags
Date: Fri, 29 Aug 2008 01:12:18 -0700 (PDT)
Message-ID: <m3hc94qlyc.fsf@localhost.localdomain>
References: <d77df1110808280409o9445f9fybcab2c8d1066a8d8@mail.gmail.com>
	<20080828231547.GD29609@coredump.intra.peff.net>
	<7viqtkd84s.fsf@gitster.siamese.dyndns.org>
	<20080828235420.GB30195@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nathan Panike <nathan.panike@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 10:13:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYz6n-0001gw-ML
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 10:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbYH2IM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 04:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbYH2IM0
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 04:12:26 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:35200 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbYH2IMW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 04:12:22 -0400
Received: by fk-out-0910.google.com with SMTP id 18so500966fkq.5
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 01:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=YSdnE/K5c68IIIgJX3n0ETSg1CLhsMA36FwozASww54=;
        b=fMhnUTNYNlvFUCYA1oQpQx8HVSGdMgp2mhf0FU68SjKE7pcIDhizsVd4IYb5+gAy8F
         VaHPkrY4r5k7iK4aQs7IXSN2i+44DMNR7VIPO6t/kW3pulgag9+5xYR0pzTZCRq1O0IZ
         8ZgbesjrJpCnp9hCkRp/hUXNmKFwj03zA1X1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=n2xU0u6/f9txu/93imKLRb/kDickHDV3nmlh11SIHE0xNYQVHsu2rjcqzDCYtrsJVN
         5BlagUTyQNhgCoNRPJHpNekJtFvrgfjhSYKXvEZRfUpaR+4aA/mUZ5JrP6mvqC7h5saK
         f2mgHCi4p1V/76M+kBa3+o+qdTlC8qLqIWPrc=
Received: by 10.180.254.18 with SMTP id b18mr3091955bki.43.1219997539229;
        Fri, 29 Aug 2008 01:12:19 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.255.225])
        by mx.google.com with ESMTPS id d13sm1749651fka.3.2008.08.29.01.12.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Aug 2008 01:12:18 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7T8CDet026706;
	Fri, 29 Aug 2008 10:12:14 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7T8CBWg026702;
	Fri, 29 Aug 2008 10:12:11 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080828235420.GB30195@coredump.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 28, 2008 at 04:36:51PM -0700, Junio C Hamano wrote:
> 
> > I was actually thinking about rejecting this, asking for something that
> > allows to express all the other %[ai][dDri] format can express, and
> > perhaps more.  So I think "%ad(short)" is a good direction to go, except
> > that 'd' is already taken.  Perhaps %a(date), %a(shortdate,local),...?
> 
> I was thinking we could accept %ad _or_ %ad(short), but of course
> introducing the latter can break existing "%ad(my other random text)"
> which is a bad idea.
> 
> I really think some consideration should be given to introducing
> arbitrary "arguments" to formatting specifiers, of which this is one
> example. Another that has been mentioned is pulling an arbitrary element
> from a list.
> 
> How do you feel about a brand new syntax (and supporting the old, of
> course) that is syntactically a little easier to extend. Like:
> 
>   %(macro, key=val, key=val)
> 
> e.g.
> 
>   %(authordate, format=short, tz=local)
> 
> where the syntax can be easily parsed without understanding what
> "authordate" means.  Jakub already suggested something akin to RPM's
> macro expansion, though I haven't looked too closely at it.

I'd rather we do not introduce yet another pretty-printing /
formatting syntax, and use the same syntax as git-for-each-ref uses
for extra formatting, 

  As a special case for the date-type fields, you may specify a format for
  the date by adding one of `:default`, `:relative`, `:short`, `:local`,
  `:iso8601` or `:rfc2822` to the end of the fieldname; e.g.
  `%(taggerdate:relative)`.

which incindentally (or not) is the same as rpm uses

  Alternate output formats may be requested by following the tag with  :type-
  tag.  Currently, the following types are supported:

  :armor  Wrap a public key in ASCII armor.

  :base64
         Encode binary data using base64.

  :date  Use strftime(3) "%c" format.

  :day   Use strftime(3) "%a %b %d %Y" format.

  :depflags
         Format dependency flags.

  :fflags
         Format file flags.

  :hex   Format in hexadecimal.

  :octal Format in octal.

  :perms Format file permissions.

  :shescape
         Escape single quotes for use in a script.

  :triggertype
         Display trigger suffix.

P.S. I Agree with %ad and the like respecting --date=<type>
-- 
Jakub Narebski
Poland
ShadeHawk on #git
