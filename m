From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Allow git-shell to be used as a ssh forced-command
Date: Sat, 18 Apr 2009 08:31:00 +0200
Message-ID: <20090418063100.GA18568@glandium.org>
References: <1239916256-10878-1-git-send-email-mh@glandium.org> <7v63h24znd.fsf@gitster.siamese.dyndns.org> <20090417234859.GY898@eagain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tommi Virtanen <tv@eagain.net>
X-From: git-owner@vger.kernel.org Sat Apr 18 08:32:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lv46Y-0006MK-8h
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 08:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbZDRGbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 02:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbZDRGbM
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 02:31:12 -0400
Received: from vuizook.err.no ([85.19.221.46]:33721 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbZDRGbM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 02:31:12 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1Lv44r-000142-No; Sat, 18 Apr 2009 08:31:04 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1Lv44q-0004r9-1u; Sat, 18 Apr 2009 08:31:00 +0200
Content-Disposition: inline
In-Reply-To: <20090417234859.GY898@eagain.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116813>

On Fri, Apr 17, 2009 at 04:48:59PM -0700, Tommi Virtanen wrote:
> On Fri, Apr 17, 2009 at 04:40:54PM -0700, Junio C Hamano wrote:
> > How does this interact with a typical gitosis installation?  I think it
> > extracts bits from the ORIGINAL_COMMAND and formulates a sanitized command
> > line and then passes it to git-shell but I do not think it removes the
> > variable from the environment.
> 
> Yup, not sanitizing. I could make that change easily, if you want, but
> there's plenty of installations out there already.
> 
> I'd say add a git-shell flag that enables any magic behavior, don't
> just magically work differently based on that environment variable.
> Sometimes that is set for reasons that are not related to what you're
> actually running in the end; e.g. "chroot /foo exec-whatever-i-gave-you".

What about triggering only when there is no option at all? Doing so
would normally terminate git-shell telling the user it's not a shell.

Mike
