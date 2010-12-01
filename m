From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Merging (only) subdirectories
Date: Wed, 1 Dec 2010 19:36:22 +0700
Message-ID: <AANLkTik-d8oys9h=wFRnyt8sukTsSymaw5LGM39BU2K=@mail.gmail.com>
References: <AANLkTimZc0r8WBOsE73V=7SKdZgONiCKfYCk7rBrCY3F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 01 13:37:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNlvf-0003hA-4O
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 13:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab0LAMgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 07:36:54 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43955 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900Ab0LAMgx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 07:36:53 -0500
Received: by wyb28 with SMTP id 28so6895420wyb.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 04:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=FM+6fWEkuFcBB5yIWOvEFvDOkiTdpVJYP4HcJhLlEfU=;
        b=RPIBBrrGArD3s9I6fUEZ0gZOIkWqCczkHF15+p+UnppaNeL8xxBL69mlgHVVGJ8+cO
         r8xqdHZW7nRokWHOzlwAMgi2wzoSUA+Opa4JnvK9IL0Ng2DSL0CKldNjEqz9ecMDUDmn
         XMOJQSBEP0sDzzoTpyHsHA2b0HVCwpmcQp0gk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qvxtLKKJjjKqmyYXZCxBc+pyAQGWstFexQpCEjpDqomh1jXC9uJbVpuUc2gUuFTXIb
         i53nVsM6kY83TcGnEizjh/3yFzGwQtsF8pMqJtCDDcvVBPoAQYyiAvFi7uHlkYrvylv4
         eRaGlHer9KLe51zHeQVK11YBS6/ScdzsJFC8w=
Received: by 10.216.50.72 with SMTP id y50mr2341270web.34.1291207012729; Wed,
 01 Dec 2010 04:36:52 -0800 (PST)
Received: by 10.216.167.193 with HTTP; Wed, 1 Dec 2010 04:36:22 -0800 (PST)
In-Reply-To: <AANLkTimZc0r8WBOsE73V=7SKdZgONiCKfYCk7rBrCY3F@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162503>

On Wed, Dec 1, 2010 at 6:18 PM, Howard Miller
<howard@e-learndesign.co.uk> wrote:
> What I would like to do is to be able to merge branch B into branch A
> but ONLY stuff that concerns the theme directory. I don't think this
> is possible. I'm reluctant to keep themes in a completely separate
> repo as that just makes testing them more problematic.

I don't know. Maybe you can use topic branch. The idea is that you and
other theme designers branch out from a known point, then make changes
in the theme directory only. You guys can merge from each other's tree
because nobody would change anything outside theme directory.
Occasionally you can merge back upstream for testing with new code,
but don't push that merge until your theme is ready. Once your theme
rolls out, you can either keep working on your topic branch, or throw
it away and branch out again.

Also, please consider submodules if theme dir is totally independent.
I don't see how it makes it problematic for testing. git-subtree [1]
might be of your interest too.

[1] https://github.com/apenwarr/git-subtree
-- 
Duy
