From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 1/6 (v2)] revision caching documentation: man page and 
	technical discussion
Date: Sun, 9 Aug 2009 16:01:22 +0200
Message-ID: <c77435a80908090701x3aa2584fq353df1886ed1b02@mail.gmail.com>
References: <op.uyb1uuu4tdk399@sirnot.private>
	 <7vbpmqi2d4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 16:01:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma8xn-0004qY-KR
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 16:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003AbZHIOBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 10:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753999AbZHIOBX
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 10:01:23 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:48251 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbZHIOBW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 10:01:22 -0400
Received: by ewy10 with SMTP id 10so2498058ewy.37
        for <git@vger.kernel.org>; Sun, 09 Aug 2009 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hh+FmIDMNeUStu/dUWirDSXphMl+vVgl+YtFIYf4NHk=;
        b=mbMNf7WaBLCF0LrtdwoZmN1FAgU7iTfei2iC92bI7C41UH4COgZyHU7MKxdLUKy/qd
         7mZi4R5N9KBkjsd4clD9gL28r/H0PayDMg8DKVAiMaSbh1BsrK/Dkrwuz8lXeDOHbLhK
         BWz5UgmFJpGpuNDQb9qFp3UHz7Qp67QPAk4rc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sqSWG3vMeykcX9OY5eU/kMS7SLgsDKR906P7R8LDT/hMNPvGk6gshn8Sz3ZCBE34JC
         FluA9RXNr33KTBaxatPLnJx4IPlgzIZCyeFqJb3PEZ+vkNL229HbdlHvjlF/mkSDAV6k
         0GbBRocr35ZIv/FA0EIij8az/DsgCkwko4grg=
Received: by 10.216.10.208 with SMTP id 58mr670674wev.82.1249826482239; Sun, 
	09 Aug 2009 07:01:22 -0700 (PDT)
In-Reply-To: <7vbpmqi2d4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125345>

Wow, thank you very much for your commentary!

Unfortunately I don't have a stable internet connection this week
(although I can get on at minimum once a day), but I'll rework the
docs today and upload a new patch for them tomorrow or the next day.
I'll also fix the file permissions ;-)

As you said, I'll answer most of your questions in the revised docs,
but I have one question about the time field size.  git uses unsigned
long internally for its commit date, so it'd be limited by the 32bits
a long is on 32bit archs.  So, wouldn't the commit times effectively
be a uin32_t?  I mean if not I can change it; I just figured I'd save
some space.

Other than that there shouldn't be an overflow problem, unless
someone's merging over 63 branches in one go.  Maybe I'll expand that
a bit just in case though...

Thanks again,
 - Nick
