From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] make the pack index version configurable
Date: Fri, 2 Nov 2007 14:42:02 +1100
Message-ID: <ee77f5c20711012042r39c6303em2a8140e8348051d@mail.gmail.com>
References: <alpine.LFD.0.9999.0711012312480.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 04:42:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InnQK-0008T7-F9
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 04:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbXKBDmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 23:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbXKBDmF
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 23:42:05 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:19715 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbXKBDmD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 23:42:03 -0400
Received: by rv-out-0910.google.com with SMTP id k20so683398rvb
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 20:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+9Q0GJVppV8WXqxkEhqKclLncEmpaDJoT0akzq9z9SU=;
        b=tBvcHHy7uWTk39fwM+uGQDnK2NpXpTFUk6nqJuSfpcH0HXHuXMFuBnVrAzQhMWISmdjKRE3pKed37KoJo/REMOuFKbCDabi9vZK9ZaZV57mkvpPAWfl+JwBrgKfuRTRtCKvzzw/xFbPhEB4NwgmMQJ45SImrLMY5lYKKgZdJZnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Czz69tcNwb2CF9RSQVvH8H0kB5tz+28OMwerOqVixL2zZ6chCW5c8yvbtwUmglWdR1j7R7bsVlxYVorD+zw8D+ZLzkAxNdSowEGPQQl+nH0q1PyXCmOQF9KXT/ceS2XMlYAhbOEem5uW9/QjSuwaOzH7ZvL3tu8tsMuzcDt6GPU=
Received: by 10.141.74.17 with SMTP id b17mr660789rvl.1193974922355;
        Thu, 01 Nov 2007 20:42:02 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Thu, 1 Nov 2007 20:42:02 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.9999.0711012312480.21255@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63054>

On 11/2/07, Nicolas Pitre <nico@cam.org> wrote:
>
> +pack.indexVersion::
> +       Specify the default pack index version.  Valid values are 1 for
> +       legacy pack index used by Git versions prior to 1.5.2, and 2 for
> +       the new pack index with capabilities for packs larger than 4 GB
> +       as well as proper protection against the repacking of corrupted
> +       packs.  Version 2 is selected and this config option ignored
> +       whenever the corresponding pack is larger than 2 GB.  Otherwise
> +       the default is 1.

If you're trying to force a previous pack version for some reason
(backward compatibility, or whatever), this "feature" of automatic
forcing version 2 for 2 GB packs might come as a nasty suprise.
Wouldn't it be better to fail with an error?


Dave.
