From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 10:44:51 -0700
Message-ID: <fabb9a1e0908131044g583f126dm6a3818b4b295eaf5@mail.gmail.com>
References: <20090813144327.GK1033@spearce.org> <20090813150446.GM1033@spearce.org> 
	<fabb9a1e0908130812s297ccfc6vd6b746daf1dcc69a@mail.gmail.com> 
	<20090813152419.GN1033@spearce.org> <fabb9a1e0908130926qdc6cdf1ka7f2442421ce12ce@mail.gmail.com> 
	<alpine.DEB.1.00.0908131907080.7429@intel-tinevez-2-302> <fabb9a1e0908131009j51c54cacp3f837f9b8525061@mail.gmail.com> 
	<20090813172508.GO1033@spearce.org> <fabb9a1e0908131028t438509d2m180293ca95daad74@mail.gmail.com> 
	<20090813174119.GP1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 19:45:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbeMc-0008Vt-Al
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 19:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbZHMRpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 13:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbZHMRpM
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 13:45:12 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:37869 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbZHMRpL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 13:45:11 -0400
Received: by ewy10 with SMTP id 10so961987ewy.37
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=v/LLGUxYVr73WPZxVmVeGPUBhYb0Kc58DGy2wQ3AIPk=;
        b=ETafGskKCf/j9t1nAkaYRPhxmaX1VJ+Opx0PK+Mux2KM67BsIaKyWouQJR/R/V0H+W
         GkQ7vAMIgV5LpvJKDgtAdbuXY3nAbO2/zpo1D7fn8oQN3eDXahtDVQvSi/9bIDvuaC2n
         1peP5GDwsirF5PQrrTjubgGkmoS8wIxaPYH44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AY4gxU9sueq598X0aHgMdGTmXwhuzx9oqlEJ1FttNMIRcsBIu5CNWHDtP60BSormIJ
         nqVXgMIHoY+vuT7x5J1POa6G13wvNkcwoXSM0J+oWhYfvsrs4zHynq8FyOv3LheubNCI
         0I7FiC6QkxLmGWukDTWIwqBmWmoqG17juXK0Q=
Received: by 10.216.86.193 with SMTP id w43mr216326wee.17.1250185511345; Thu, 
	13 Aug 2009 10:45:11 -0700 (PDT)
In-Reply-To: <20090813174119.GP1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125848>

Heya,

On Thu, Aug 13, 2009 at 10:41, Shawn O. Pearce<spearce@spearce.org> wrote:
> Uh, no, if we have "option import-marks=..." and we can't find the
> file "..." and we have no --import-marks command line flag that
> would have overridden it, we need to abort with an error.

Ah, then how about in option_import_marks() we only store the name of
the file, like in option_export_marks, and at the end, when we reach
the first non-option command (and we've parsed argv), we read the
file. That way it's only read once, and it deals with the above
scenario.

-- 
Cheers,

Sverre Rabbelier
