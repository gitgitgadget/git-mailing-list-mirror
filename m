From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCHv3 0/3] git-gui: more robust handling of fancy repos
Date: Sun, 6 Dec 2009 13:59:22 +0100
Message-ID: <36ca99e90912060459u1073288bj2114f8ab56c7224b@mail.gmail.com>
References: <1250467128-29839-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <36ca99e90910270435h69c1e983j78ff9ec49e7e8eae@mail.gmail.com>
	 <cb7bb73a0912060014p548884e0g8c4510a5b562901b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 13:59:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHGi6-0001wg-Ba
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 13:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464AbZLFM7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 07:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756337AbZLFM7S
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 07:59:18 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:59881 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345AbZLFM7R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 07:59:17 -0500
Received: by fxm5 with SMTP id 5so4005923fxm.28
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 04:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=SSXM974AcfOzTpHzqpD4un01PbVVzy7IdM1uF2JeP38=;
        b=FMKR5SAdBtxyy9dG/ANpxirB8GVbWWISCrVT/EBYs4exSYIIDaQM752omKFOgjQTIC
         3GfRYhKyd+qAqMSAHXkf7kicabgigKxdVk9e27nZyU5vbTlPoTYCir34xe/eS3HdAfrW
         2xGESGDLy6VyzfMzYTS3SUCZJqY1fZoQAPHfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=HmPBj2QwtkRRHAYshMUzjrqv+66PFYeMSX5kTVaxAWBCXYXb29rRLEd77NF4y225DP
         CHy/G3+1sv3BLSRx00WXU26QDhwrcydUODmRxC9OS1Cz7DezoOfY2xV4U6/DKuTh/Blw
         7FPm0BKj3kKIaauPtQU93MIDLwKarD7MJS8OE=
Received: by 10.223.6.9 with SMTP id 9mr804316fax.84.1260104362940; Sun, 06 
	Dec 2009 04:59:22 -0800 (PST)
In-Reply-To: <cb7bb73a0912060014p548884e0g8c4510a5b562901b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134658>

On Sun, Dec 6, 2009 at 09:14, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> On Tue, Oct 27, 2009 at 12:35 PM, Bert Wesarg
> <bert.wesarg@googlemail.com> wrote:
>>
>> I would also suggest to always export GIT_DIR into the environment, so
>> that guitools can relay on this.
>
> I'm sorry I couldn't reply to this email earlier. I have never used
> this feature, but if you can provide some example guitools
> configuration I'll gladly move the environment export earlier and test
> it.
Here it is:

[guitool "exclude/Ignore file"]
	cmd = echo \"$FILENAME\" >> \"${GIT_DIR:=.git}/info/exclude\"
	noconsole = yes
	needsfile = yes

The purpose is simple: add the current file to the info/exclude file
in the git dir As you can see, I have a workaround for not having
GIT_DIR in the env, which should solve the issue. But it would be nice
to rely on this.

Bert
>
> --
> Giuseppe "Oblomov" Bilotta
>
