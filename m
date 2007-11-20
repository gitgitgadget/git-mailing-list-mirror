From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] gitweb: Try to sanitize mimetype for 'blob_plain' view
Date: Tue, 20 Nov 2007 00:07:56 -0800
Message-ID: <7vlk8tl4pv.fsf@gitster.siamese.dyndns.org>
References: <1195484054-18164-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 09:08:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuO9e-00026z-W9
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 09:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960AbXKTIIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 03:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756838AbXKTIID
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 03:08:03 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:51896 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbXKTIIB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 03:08:01 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 556B52F0;
	Tue, 20 Nov 2007 03:08:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E1E34969F5;
	Tue, 20 Nov 2007 03:08:19 -0500 (EST)
In-Reply-To: <1195484054-18164-1-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Mon, 19 Nov 2007 15:54:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65532>

Jakub Narebski <jnareb@gmail.com> writes:

> Use 'text/plain' for files which are text and can be viewed in a
> browser, and are not among a few 'text/*' mimetypes universally
> recognized by web browsers.  This means files with 'text/*' which are
> not text/html, text/css, text/sgml or text/xml, and files with
> 'application/x-*' mimetype which are nevertheless text: javascript,
> shell, Perl, Tcl, (La)TeX,...
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> Tired of my web browser (Mozilla) asking me what I want to do with
> shell script, Perl script or LaTeX document when using 'blob_plain'
> (raw) view,...

I admit that I share the irritation, but I've felt that solving
it this way by discarding information is going backwards, and
the kosher solution is to tell the browser what to do with these
unknown mimetypes.  Unfortunately this needs to be done by the
user -- I do not think the server can.

On the other hand, maybe the people who are browsing the plain
view from the browser do not need to have the content marked as
written in what programming language.  I dunno.
