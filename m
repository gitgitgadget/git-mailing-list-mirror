From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Unmodified submodules shows up as dirty with 1.6.6.443.gd7346
Date: Tue, 19 Jan 2010 06:31:51 -0800
Message-ID: <8c9a061001190631rb1f9518sff337e07e0a6803@mail.gmail.com>
References: <4B547EA6.5070203@isy.liu.se> <8c9a061001180802t5ec0d389j2cae9f1771130c36@mail.gmail.com> 
	<4B555BA1.90605@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org,
	Jens.Lehmann@web.de
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 19 15:32:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXF8M-0003FI-MS
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 15:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912Ab0ASOc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 09:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064Ab0ASOcM
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 09:32:12 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:56343 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524Ab0ASOcL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 09:32:11 -0500
Received: by pwj9 with SMTP id 9so2416733pwj.21
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 06:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=VPUl6RzwcAycIM9q2FNpFnDFiZkoc30t46SigJJrL3o=;
        b=wSngY/+ziYQpWvD94yaaOSOHLXaqHkZA9Ez+XMQOESluxpH29IfmGlDSRCGd87KgHj
         66NSjVHORGSWhJEjMZlNSKFiI5m6OQzHFRLSPDqITQFHyqtrvxx8FvbQZRSEso3gsQwH
         /XY1DBX3iLuJOOf0pf/shD3Cv9TLY2xLQz1GY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=LaT2+40nHAEJiuztZqIu9crKz+krJ6OmmgjWldiatUpDEcPKal5rQ5/PsBgc/dDY+7
         1o3/DeEV8eaQJ0q4IzHHHgjqhN5KWSLjb3eQvoYT8oa8vdqaMtOokoAsPKc8cKMuZPgr
         UoLuI71IrZjn2oxCiNhfgwsW6+ro4HcelNHfY=
Received: by 10.141.2.4 with SMTP id e4mr5429176rvi.136.1263911531070; Tue, 19 
	Jan 2010 06:32:11 -0800 (PST)
In-Reply-To: <4B555BA1.90605@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137460>

On Mon, Jan 18, 2010 at 23:13, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Jacob Helwig schrieb:
>> If there is no output from git status in the submodule, then git
>> status in the superproject shows the submodule as being clean.
>> However, if there is _any_ output from git status (untracked files,
>> modified files, deleted files, new files), then the superproject shows
>> the submodule as being dirty.
>
> But isn't it a bug that a submodule is considered dirty just because an
> untracked file appears?
>
> -- Hannes
>

I wouldn't consider it a bug, but that's specific to my use case of submodules.

At work, we're using them for shared Perl libraries between projects.
The only reason we have for creating new, untracked files in the
submodule is that we're adding new library code.  Having the submodule
show up as dirty for us is another safety towards not forgetting to
commit & push out this new code.

I agree that this isn't intuitive given how status normally handles
files in projects, but it makes sense (to me, anyway), when dealing
with library code.

Should this be the default behavior for everyone?  I can't say.  If
it's not, I would at least like it to be behavior that you can opt-in
to.

-Jacob
