From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: clean/smudge filters on .zip/.tgz files
Date: Wed, 27 Feb 2013 07:39:10 +0100
Message-ID: <512DAA0E.9010401@viscovery.net>
References: <20130226163800.454cd093@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 07:39:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAag1-00042J-Ul
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 07:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292Ab3B0GjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 01:39:16 -0500
Received: from so.liwest.at ([212.33.55.24]:44067 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265Ab3B0GjP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 01:39:15 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UAafX-0000t7-90; Wed, 27 Feb 2013 07:39:11 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D3C7F1660F;
	Wed, 27 Feb 2013 07:39:10 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <20130226163800.454cd093@bigbox.christie.dr>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217195>

Am 2/26/2013 23:38, schrieb Tim Chase:
> Various programs that I use ([Open|Libre]Office, Vym, etc) use a
> zipped/.tgz'ed file format, usually containing multiple
> (usually) plain-text files within.
> 
> I'm trying to figure out a way for git to treat these as virtual
> directories for purposes of merging/diffing.  
> 
> Reading up on clean/smudge filters, it looks like they expect one
> file coming in and one file going out, rather than one file
> on one side and a directory-tree of files on the other side.
> 
> I tried creating my own pair of clean/smudge filters that would
> uncompress the files, but there's no good way put multiple files on
> stdout.
> 
> Has anybody else played with such a scheme for uncompressing files as
> they go into git and recompressing them as they come back out?

I attempted to do something like this for OpenDocument files (I didn't get
very far) until I discovered that LibreOffice can save "flat open document
files". That combined with the option "save files optimized" switched off
results in fairly readable XML in a single file that can even be merged
under some circumstances.

You would still need a clean filter that normalizes the style numbers,
cross reference marks and other stuff that changes each time LibreOffice
saves the file.

-- Hannes
