From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Simple update to bash completions to prevent unbound variable errors.
Date: Tue, 13 Jan 2009 08:35:56 +0200
Message-ID: <87hc43emr7.fsf@iki.fi>
References: <496C0003.7040909@tedpavlic.com>
	<7vy6xfew2n.fsf@gitster.siamese.dyndns.org>
	<200901122157.03658.bss@iguanasuicide.net>
	<496C19E0.6060308@tedpavlic.com> <496C1D90.1020609@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 07:38:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMcuq-0002IZ-Vv
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 07:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756364AbZAMGgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 01:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756079AbZAMGgb
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 01:36:31 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:46267 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751902AbZAMGga (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 01:36:30 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 48FC5A8803A671D3; Tue, 13 Jan 2009 08:36:04 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LMcsW-0002ar-LC; Tue, 13 Jan 2009 08:35:56 +0200
In-Reply-To: <496C1D90.1020609@tedpavlic.com> (Ted Pavlic's message of "Mon\, 12 Jan 2009 23\:50\:24 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105461>

Ted Pavlic (2009-01-12 23:50 -0500) wrote:

> NOTE: On my system, I save git-completion.bash to .git_bash_completion.
> Because of that, Vim can't ftdetect off of the file name. The modeline
> allows ft=sh even when you don't end in .sh or .bash.
>
> An alternative (to a Vim modeline) is to put
>
> #!bash
>
> at the top of the script. That would do the same thing as the modeline
> (even though it would never actually get used by the sourced "script").

Another way is to set filetype detection locally. This way the project
files don't get filled with editor-specific stuff. You may want add
something like the following to your ~/.vim/filetype.vim file:

    augroup filetypedetect
            autocmd BufNewFile,BufRead .git_bash_completion  setl ft=sh
    augroup END
