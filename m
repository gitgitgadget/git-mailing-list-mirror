From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible regression in git-rev-list --header
Date: Wed, 3 Jan 2007 11:35:17 +0100
Message-ID: <e5bfff550701030235g6f26044h8dd73e8abe1ec9e3@mail.gmail.com>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
	 <7vlkkphvrb.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v64bsj0s4.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550612310345j4c882b7av51879ca1175a1c6b@mail.gmail.com>
	 <Pine.LNX.4.63.0612311613180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550612310743t4ca1b017ubceddffafd06ac59@mail.gmail.com>
	 <7vodpja0u8.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550701030121n700fab25x63278457c884a3f7@mail.gmail.com>
	 <8c5c35580701030221w5c04e2eaq757d12c4ca0b0780@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 03 11:35:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H23T9-0000Uy-FG
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 11:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbXACKfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 05:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbXACKfU
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 05:35:20 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:57863 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbXACKfT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 05:35:19 -0500
Received: by py-out-1112.google.com with SMTP id a73so2613462pye
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 02:35:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IjPj0LVLhV1ZV1c9Z8pHmR2mhyaKNXsto5n8lhw0C7lpbuqmGj5RqMapVOq7oJYQ40p7vAghoJ3wYNQH7kGjMGhPFxoghINvaRARm/8ZXCisp1La+eVISVudyvQUrMe54MDeCB+FIkIzpdKGaA+LLxZIJ1KG1alekVme3b014Ec=
Received: by 10.35.70.17 with SMTP id x17mr39487426pyk.1167820517896;
        Wed, 03 Jan 2007 02:35:17 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Wed, 3 Jan 2007 02:35:17 -0800 (PST)
To: "Lars Hjemli" <hjemli@gmail.com>
In-Reply-To: <8c5c35580701030221w5c04e2eaq757d12c4ca0b0780@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35856>

On 1/3/07, Lars Hjemli <hjemli@gmail.com> wrote:
> On 1/3/07, Marco Costalba <mcostalba@gmail.com> wrote:
> >         - one blank line
> >         - zero or one line with log title
> >         - zero or more lines with log message
> >         - a terminating '\0'
>
> I think the should be:
>   -zero or more blank lines

Isn't it zero or _one_ blank line? Why more then one? would be it
useful? surely is slower to parse.

>   -zero or more non-blank lines with log title

multi lines titles are allowed? never saw one of them.

>   -zero or more blank lines

Why? this is necessary only to disambiguate muti (non blank) lines
titles, but as Junio pointed out distinction between log title and log
message is only in the Porcelain, not encoded in git. So the Porcalain
is going to show _one_line title if any an the remaining stuff in the
log message.

>   -zero or more lines with log message
>   -a terminating '\0'
>

 Marco
