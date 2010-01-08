From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Linking multiple Git repositories for version tracking
Date: Fri, 8 Jan 2010 13:34:11 -0500
Message-ID: <32541b131001081034k67664652h6f6e9a007175c260@mail.gmail.com>
References: <op.u573txvdn3qeew@klee> <op.u574cwxqn3qeew@klee>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: James Beck <james@jmbeck.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 19:34:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTJfQ-00031w-Ne
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 19:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455Ab0AHSec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 13:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753102Ab0AHSec
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 13:34:32 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:49436 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126Ab0AHSeb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 13:34:31 -0500
Received: by yxe26 with SMTP id 26so18936525yxe.4
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 10:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=4ktO2208SpSkP0Zt57F5gmDG3qVZdG6gsAZmEtWscC4=;
        b=Cee+80YPLWUD0iwDt7Ivtklje5s11K0jeRPLfQ/dBheJUcOkfehzfiKTNuRf15eKos
         oa/h1KNpOQ3PFNNAjSljTzOMLOZ8eDDjauZ3QDe1a5zL93ZMxc502ZEOT6aajuvLbDBI
         R0Ufw/5474Ed/beV6ziFowu6T85hy1iDoyXfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=NcKIDxECiiXgdCLn3Vg/0wEPK9Xe9oR1cpyVJanWOI14oJ9IUZ3a14eLghQEr/wM82
         ZVBxScrucxAV13H5GIVkn97fomxLWFVnx+xacdyDaSWE0fVixP2z19LTp7QPw4qgu+8+
         wMndO85dsykQSiGdTbdsy5CWBChwP89b5a1BY=
Received: by 10.151.88.42 with SMTP id q42mr5902434ybl.75.1262975671060; Fri, 
	08 Jan 2010 10:34:31 -0800 (PST)
In-Reply-To: <op.u574cwxqn3qeew@klee>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136463>

On Fri, Jan 8, 2010 at 12:03 PM, James Beck <james@jmbeck.com> wrote:
> I'm developing firmware that is composed of multiple projects. Each
> section of the firmware has it's own git repository (each section
> correlates to a physical processor). But the firmware as a whole is
> getting to the point where I have to remember which version of Firmware A
> is compatible with Firmware B. If I add a feature to B that requires some
> tweaks in A, I need to know that both A v3.04 and B v2.7 need to be used
> together.
>
> I'm starting to move into alpha with this code, so I really need to have a
> system that keeps track of compatible firmware versions. The best I can
> come up with is a plain text file (or Excel spreadsheet) that lists the
> overall firmware version, and the Git hash for each individual project.
> That way, if I want to load up a particular firmware version, I can
> checkout each hash for that version. Seems foolproof, but not terribly
> easy, and somewhat annoying.
>
> I know submodules might be used, but it's not super obvious how to make
> their paradigm work nicely here. (You check out a version you want, and
> then list all the submodule git hashes for that version? What happens if
> one hash needs updating? Do you branch it?) It seems more complicated than
> I'd like.

This seems like exactly what submodules were designed to do.

1. create a "superproject" for each physical product

2. use submodules to link to the right firmware versions for that product

3. when you make a new release of that physical product, update the
firmware links.

4. when someone wants to check out a particular version of the
product, they retrieve the product's repo and ask git submodule to
checkout the submodules.

Which part is not working for you?

Have fun,

Avery
