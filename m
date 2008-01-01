From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH WIP] sha1-lookup: make selection of 'middle' less aggressive
Date: Tue, 1 Jan 2008 09:40:21 +0100
Message-ID: <e5bfff550801010040k59c9608do1acb9da548620f85@mail.gmail.com>
References: <7vd4soa3cw.fsf@gitster.siamese.dyndns.org>
	 <7vtzm08l9w.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.1.00.0712301150120.32517@woody.linux-foundation.org>
	 <7vodc77t0o.fsf@gitster.siamese.dyndns.org>
	 <e5bfff550712301404g273dd092w9b36b48d94ed1e70@mail.gmail.com>
	 <alpine.LFD.1.00.0712311232520.32517@woody.linux-foundation.org>
	 <20080101063616.GA21605@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 01 09:40:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9cg6-000304-QK
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 09:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbYAAIkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 03:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbYAAIkW
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 03:40:22 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:25349 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbYAAIkV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 03:40:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4845582rvb.1
        for <git@vger.kernel.org>; Tue, 01 Jan 2008 00:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Yx2sG0K40di6v7WnkV2crSoONLTyJk7LHy1xK1Hl0/w=;
        b=H6maVhmZte/RPV56K+147yY05Rj074UAGVp1nsokw1pyJbRDonI1LLrlEo79TUB657CWzmo7+I1qeiqvtpH7exJlZsr3PP7YQdC3cnMY9GefQtIFF4tzkfJado5yuXyN16GMWsxi9EyaBp8Dahq39CiqGCyysOegZR9dxskJ39Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hsGheCu5lwKeqmHcdui+oKL7nLDm9SqSEsahv0hx9EUNhVp4OtKQdgxw3mxQCAS5Fp/ADu0A6BgO6Q8EMzbOJNbpCeF63OmlJ8YFsifpvSS1kUizWk+VvCiCIKG4DpPEaeleanjEm0MZeVYmmVBhE8pJNzkM2rIplKjmmwWdFGc=
Received: by 10.141.141.3 with SMTP id t3mr1208759rvn.52.1199176821330;
        Tue, 01 Jan 2008 00:40:21 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Tue, 1 Jan 2008 00:40:21 -0800 (PST)
In-Reply-To: <20080101063616.GA21605@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69433>

On Jan 1, 2008 7:36 AM, Jeff King <peff@peff.net> wrote:
>
> The packfile is noticeably larger (55M versus 40M)

Well 55M versus 40M is _only_  27% of compression ratio. It means that
the compression algorithm is not so fundamental because the data is
already, how to say, well packaged.

IOW if a compression algorithm X is say 30% less size efficient then
zlib it means that the final packfile size using X would be 44.5M
instead of 40M, i.e. only 11% bigger then using zlib.


Marco
