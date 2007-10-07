From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Support tags in uncommit - use git_id instead of rev_parse
Date: Sun, 7 Oct 2007 22:06:19 +0100
Message-ID: <b0943d9e0710071406k38387ee0w961f403c57794159@mail.gmail.com>
References: <20070930172647.18972.49369.stgit@tt.roinet.com>
	 <b0943d9e0710011500o1bd621a4q10dfe0468c8795e2@mail.gmail.com>
	 <1191362591.26879.3.camel@dv>
	 <b0943d9e0710031335o1c7f3a10i6f2055b76376bfd4@mail.gmail.com>
	 <1191447892.31052.5.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pavel Roskin" <proski@gnu.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 23:07:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IedL7-0001Qm-HE
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 23:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040AbXJGVGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 17:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbXJGVGU
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 17:06:20 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:52615 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbXJGVGT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 17:06:19 -0400
Received: by rv-out-0910.google.com with SMTP id k20so582389rvb
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kpNkOISRJaa5wRNAEWm/NoW/A3OvaEU9N2wDaw4Lq6o=;
        b=qNbbGUZGB7DDEq5B3SSgGWVMDt+BI0B4psQF7fhVTekosfydjUUpuXZrVBPIgos2jaBIv4SWhIxP7jE6mzvLsUimJbVIS+qevftkrxofuW/Dx9lQwiAqWiYTDCHUjTxwMGCgsZoajw/Xv697B7vieBiS5fDNTJXGAVQaFOUYJsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BB73h5clSmm5FREF2sMD0xy8M2FBBbfE9LBqNGpwJOr+FpD78KKAEgtPHEPp11MCVOnjRZJpreRd2AiO2YgbtT2vnXtLqrm/hLGSoJZCdTZ/oK/+16gM9ZKFuvBimT5rNyfA/IQHdtE4XoOlkgPwHvebrL9xApGjtPC+WIqmNjg=
Received: by 10.141.42.10 with SMTP id u10mr2590655rvj.1191791179333;
        Sun, 07 Oct 2007 14:06:19 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Sun, 7 Oct 2007 14:06:19 -0700 (PDT)
In-Reply-To: <1191447892.31052.5.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60217>

On 03/10/2007, Pavel Roskin <proski@gnu.org> wrote:
> On Wed, 2007-10-03 at 21:35 +0100, Catalin Marinas wrote:
>
> > Without this patch, the 'stg uncommit -t patch' fails with 'Unknown
> > revision: patch'. With the patch applied, it still fails but with
> > 'Commit ... does not have exactly one parent'. I don't say that the
> > first one is good but I don't think the latter is clearer. The 'stg
> > uncommit --help' states that the '--to' option takes a commit argument
> > but if one passes a patch name the error message gets pretty
> > confusing.
>
> Actually, 'Commit ... does not have exactly one parent' means that stg
> misinterpreted the patch name as some non-existing hash and started
> iterating back until it hit the first merge.
>
> Perhaps stgit should make sure that the hash is valid before walking the
> commit tree.  If it's not, stgit could provide a better message.

OK, I applied your patch but I'll have to look into the error message
to make it more meaningful. Thanks.

-- 
Catalin
