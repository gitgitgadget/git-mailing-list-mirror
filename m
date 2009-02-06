From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 5/6] gitweb: last-modified time should be commiter, not 
	author
Date: Sat, 7 Feb 2009 00:00:11 +0100
Message-ID: <cb7bb73a0902061500x12105a13la78703918937fe4b@mail.gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200902050038.57999.jnareb@gmail.com>
	 <cb7bb73a0902060314u4741528bs196a43d45ff7f283@mail.gmail.com>
	 <200902062212.08857.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 00:01:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVZhe-0005oV-4L
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 00:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbZBFXAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 18:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbZBFXAO
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 18:00:14 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:54243 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbZBFXAN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 18:00:13 -0500
Received: by ey-out-2122.google.com with SMTP id 25so281846eya.37
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 15:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MRK+V/alne9u2j97lpFbE2NSA0ZrVw7YtwqzapB3B0M=;
        b=s0/wIVfyEC9wp02nvDrivK4zVaKiU5lIkxKAk3he6TmqlWc4yOgrI0evyv0ldrp47f
         x0LmGLw0xywQtmTi1xKcPB8Rxmwk4Lz9JJyR/ryvEGWsOF3puS54BefyJoWixkTXvrp8
         XjGf+GthZi4FgSjIysvU+Ol8r7EpYpyE9Wpk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PEkQT9p4yxRm31suOwt1XvYxK8yHfbN8cMXMBoc5e+cV+DYb/RbWE9n/PUbZJcxB8q
         avCsHBgmRzUt1e6r6dhnEFSk6r0tbP+XgxZcVSRu98WYTnpjlBiNUIl6emh/RftN0be3
         oGvMzZlWlPXadkQXVjO3H7gBZdtSDFh609KZ8=
Received: by 10.210.137.17 with SMTP id k17mr1685947ebd.138.1233961211649; 
	Fri, 06 Feb 2009 15:00:11 -0800 (PST)
In-Reply-To: <200902062212.08857.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108798>

On Fri, Feb 6, 2009 at 10:12 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Using update time does ensure that it is monotonical, and it
> wouldn't ever be earlier than the time repository started to be
> available, but it changes from clone to clone.

I don't think it changing from clone to clone is a problem. Monotony
and the ability to properly catch when the underlying data really
changed are much more important factors. After all, there is no
_requirement_ that Last-Modified be used for If-modified-since headers
(although it is recommented, and clients that don't follow the
recommendation are warned to be aware of all possible odd problems
arising from not using it).

The real question is: _how_ do you get the (branch) update time?


-- 
Giuseppe "Oblomov" Bilotta
