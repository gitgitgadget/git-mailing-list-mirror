From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH] Makefile: default to -lcurl when no CURL_CONFIG or CURLDIR
Date: Mon, 28 Apr 2014 13:48:48 -0700
Message-ID: <CAD0k6qQ+jbFqxpUfH9pm1koicpkqesCbUXxbcW_+ocgLDUOkjQ@mail.gmail.com>
References: <1398714653-1050-1-git-send-email-dborowitz@google.com>
 <20140428200550.GO9218@google.com> <CAD0k6qR766hrgUtyiGzZ9KM5woknfsyUm3Mf1-Pm3M-LrL2Zhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:49:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WesUJ-0000lj-58
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330AbaD1UtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 16:49:12 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:48626 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374AbaD1UtK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 16:49:10 -0400
Received: by mail-lb0-f177.google.com with SMTP id z11so5323723lbi.22
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 13:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xRlPI0zCtlJ7SkM5CNXZb5cEqzL++HgvmtC7FSCtH5k=;
        b=eXKglSqXAmdemKtx/nCWHA3PIPUfz9jG8AiF2lJtJ0PH/mhB1nnmi7l9dnOkXeNzn/
         76xAGWZkGfGxV75StPFcoQM/Kg8hdhyzbW743oXVauGtacYuT82jXkvP+rTgBqwpdjaT
         Bfq9o68vwBxb/9VEZ6e528D+lUWvhmQEk2glgYIQLPWemfkiYi0LzB9cB8esCRSVGUQE
         7lxBbh6SCRsOv5Mvzfxi7IugPNKRYZ2D4eWlamlcCOcwLSgANKLntPR5ObEISiB3g+Sk
         zQ3s+qm5aLWIEuuJZFI1wD+YOLMuW+Lew7E7yQlYpi47qI2MEUfJkIkmFTXds/3maBCw
         e52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=xRlPI0zCtlJ7SkM5CNXZb5cEqzL++HgvmtC7FSCtH5k=;
        b=F3R51sqeUOTUQeh6mLAYfjbpOKNOyj8j9w4ariquX+RYdKJ/GDqEtsZ3i0HBvbxysf
         oNB40mvYgR5EwLvDO/z/WyeMmaZtz9GFDyL1UjPkg4Xlh8lvDNkVJW4iFpPt0Ty4aEg4
         zAIDdtfCfVtD4MmdR7IzUHBU8iZzjf4gtu5WO3gX+sx9aO5ycwzghWmHdKvDu4ntgGRH
         6q4kYSFOsruCMy5pAVa5TG4rfd8+RTQvSoHoGiksZYZPjKcKlOkOJjG6x6NMwdbxsI39
         rNTc8q2VA2BUrA6wMa15vYFu4VbrW6N5OGgwkyGOHDRyPD17D94cFKzGkBnzw/OfLo6h
         T6Cw==
X-Gm-Message-State: ALoCoQkt4PRdBLfrC4kF1yJ2boQo8SaEMYbaBPHFoSgvBsCUtGg1W8UmjiTaRavl36++kzIGw7zG7T/iWDYxn+PU4ha8RVzGT/RwJt9fWEFwrjkK1ZvRVep6FNlu033IAzZIxyOs4x4RrZApaFKrlTzqZ3Wv/klAnpdJUfdsisgpfk1rpnmys1Ox4ed0fARrScYPhFFeTYuH
X-Received: by 10.112.160.168 with SMTP id xl8mr19700868lbb.3.1398718148751;
 Mon, 28 Apr 2014 13:49:08 -0700 (PDT)
Received: by 10.112.184.227 with HTTP; Mon, 28 Apr 2014 13:48:48 -0700 (PDT)
In-Reply-To: <CAD0k6qR766hrgUtyiGzZ9KM5woknfsyUm3Mf1-Pm3M-LrL2Zhg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247445>

On Mon, Apr 28, 2014 at 1:46 PM, Dave Borowitz <dborowitz@google.com> wrote:
> How about:
> "If CURL_CONFIG is unset or points to a binary that is not found,
> defaults to the CURLDIR behavior. If CURLDIR is not set, this means
> using -lcurl with no additional library detection (other than
> NEEDS_*_WITH_CURL).

Even better, I'll move the blurb about CURLDIR behavior to CURLDIR.
