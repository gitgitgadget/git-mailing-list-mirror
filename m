From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 3/4] Speed up is_git_command() by checking early for
 internal commands
Date: Sun, 5 Jan 2014 14:42:08 +0100
Message-ID: <CAHGBnuNNaKNx7FzjoNhorryR5eO2c0VvbUgRc_p01mabOVr+EA@mail.gmail.com>
References: <52C58FD7.6010608@gmail.com>
	<52C59107.6080005@gmail.com>
	<371D58A5-4640-4125-9B69-E9A7B03B347F@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: "Kent R. Spillner" <kspillner@acm.org>
X-From: git-owner@vger.kernel.org Sun Jan 05 14:42:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vzny3-00030O-4e
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 14:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbaAENmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 08:42:10 -0500
Received: from mail-qe0-f41.google.com ([209.85.128.41]:52557 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaAENmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 08:42:09 -0500
Received: by mail-qe0-f41.google.com with SMTP id gh4so17601379qeb.28
        for <git@vger.kernel.org>; Sun, 05 Jan 2014 05:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8MXqGrc/dKHHJouvLWnto3HzlT/EKS4r5UhFN3VbJMM=;
        b=gPqHUNslpIrWzB8cF0Kv6G0B0n7toj8M8RJ1rxjz+PC3USPOeXvIsk0UO5uLvUdiY3
         ANLKw99Bw3iQBPywXiDsOO3/HxIjZl8XIhezehzHhXEAO7Lx5TzfNcrl5zM0ZRsoaI65
         cx4p+x39rA1uPMahyQGOKik7x4PiQd2bb37Jo4jKJwSFw00WasEkJGGd3EOStvnM4uPq
         HIvKB+78s1MQpzgoqn+F+pTKXCy26KX9x0lEejNWcQNPOVFWbkQy4pbyzsE8jkuVIUi6
         kDMJmv3ghFfaEA2xciJB9y507bgq9kqmkR41ivwFZZ+VjAwHLnKqkfmkBNHna4KpB0lQ
         tB9g==
X-Received: by 10.49.94.212 with SMTP id de20mr175200519qeb.51.1388929328836;
 Sun, 05 Jan 2014 05:42:08 -0800 (PST)
Received: by 10.96.22.229 with HTTP; Sun, 5 Jan 2014 05:42:08 -0800 (PST)
In-Reply-To: <371D58A5-4640-4125-9B69-E9A7B03B347F@acm.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239966>

On Fri, Jan 3, 2014 at 5:49 PM, Kent R. Spillner <kspillner@acm.org> wrote:

>> Since 2dce956 is_git_command() is a bit slow as it does file I/O in the
>> call to list_commands_in_dir(). Avoid the file I/O by adding an early
>> check for internal commands.
>
> Considering the purpose of the series is it better to say "builtin" instead of "internal" in the commit message?

True, I'll fix this in a re-rool.

-- 
Sebastian Schuberth
