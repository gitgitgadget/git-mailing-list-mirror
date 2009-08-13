From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 13:01:16 -0700
Message-ID: <fabb9a1e0908131301g4361a06es98fbf3c256c25300@mail.gmail.com>
References: <1250140186-12363-2-git-send-email-srabbelier@gmail.com> 
	<alpine.DEB.1.00.0908131652190.7429@intel-tinevez-2-302> <20090813150446.GM1033@spearce.org> 
	<fabb9a1e0908130812s297ccfc6vd6b746daf1dcc69a@mail.gmail.com> 
	<20090813152419.GN1033@spearce.org> <fabb9a1e0908130926qdc6cdf1ka7f2442421ce12ce@mail.gmail.com> 
	<alpine.DEB.1.00.0908131907080.7429@intel-tinevez-2-302> <fabb9a1e0908131009j51c54cacp3f837f9b8525061@mail.gmail.com> 
	<20090813172508.GO1033@spearce.org> <7vzla3bjn5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 22:11:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbgdq-0002cO-1L
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 22:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018AbZHMUBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 16:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755834AbZHMUBi
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 16:01:38 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:33379 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756004AbZHMUBg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 16:01:36 -0400
Received: by ey-out-2122.google.com with SMTP id 22so207906eye.37
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Wb9HBOMKJH/RGsTsM0CBAL/z+GYZUrBMz4r0E1TKtxk=;
        b=bdj3N8/1UpcAr8H9gGuPb/cQzV+IatUiwKDG+D1LfNrLvyWAmvguo62B5jCSjxZ829
         pDT5ntX2zXnKl4DqzkJqnnKkv0LhxRqyP8MaltnAAeZjvZvRxHq4MROcUdUs1OfaI54h
         7AWBlx2L6UMg6mJJkvhFqIaAMyCnAzhQAColc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lov6ZxRdslDXd1j58Y0vKrS/yFxsNysyLrXl+TuP8Q1re7idkfmRYz4Putn16MJ1jB
         k0ExdGfDjdfs1Tf9LBpXc+pcYjUUyZr0PDpr8vr9V8Uy+u+H2WUTWYuieI0BJ9OKNIJz
         T/SD6nPiETtGjTi70JPlKA3oH9uDlZaqgrB/o=
Received: by 10.216.86.193 with SMTP id w43mr241435wee.17.1250193696508; Thu, 
	13 Aug 2009 13:01:36 -0700 (PDT)
In-Reply-To: <7vzla3bjn5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125863>

Heya,

On Thu, Aug 13, 2009 at 12:26, Junio C Hamano<gitster@pobox.com> wrote:
> How about making the option parser get and keep the _name_ of the file
> until option parsing session (i.e. read the stream until initial run of
> "option" command runs out and then parse the command line to override),
> and then finally open the file and read it?

On Thu, Aug 13, 2009 at 10:44, Sverre Rabbelier<srabbelier@gmail.com> wrote:
> Ah, then how about in option_import_marks() we only store the name of
> the file, like in option_export_marks, and at the end, when we reach
> the first non-option command (and we've parsed argv), we read the
> file. That way it's only read once, and it deals with the above
> scenario.

Which is exactly what the latest version does :).

-- 
Cheers,

Sverre Rabbelier
