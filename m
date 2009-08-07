From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v2] Re: mailinfo: allow individual e-mail files as input
Date: Fri, 7 Aug 2009 06:39:29 +0200
Message-ID: <20090807043929.GJ12924@vidovic>
References: <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil> <fmF7fF0TYh9QnFuUzmi-Zw9fKRhYn2-S-kCVb2e-d84D87BPqjfwrwFursOoLGkB99qKJmb_oRs@cipher.nrlssc.navy.mil> <20090807015238.GF12924@vidovic> <20090807015628.GG12924@vidovic> <4Frzb2o8m7o4sjOhlZiN-mXQHUAsXYeImlNxZ8ANJZ5I3_S_JjSsoA@cipher.nrlssc.navy.mil> <20090807023126.GH12924@vidovic> <7GvFnE4br-8WnXmtoea9V1LPY-qshCw6arPr6H40SRG59-b7YcpTsw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	giuseppe.bilotta@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Aug 07 06:39:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZHEy-0006K4-Tl
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 06:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbZHGEjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 00:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbZHGEjd
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 00:39:33 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:51680 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbZHGEjc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 00:39:32 -0400
Received: by ey-out-2122.google.com with SMTP id 9so461413eyd.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 21:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=7bjh8Rw3vLxT3bk+0Fg7S7OQjy5ZXd9k0KBiJdCiQ9k=;
        b=dahG+GCaSZXwXesNWjpSzx/TNgayurvDzbQ3F/LvWebe9oiRLC+9Nzlrl5gL1cWCL5
         cm8QAjm8RWtGAdtfxFawT+Oh7zt94fHAsDtWAkH467dVDXFDlGhZVOuT3qCkkoCk1x2u
         yA3XgdFwseCTFIRFXqlpQrSca6RSxEoqQVLuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FmNiy1DQoflXK2R7b3yVcMJt4et2JJ05wtQuBDRRR3w9j9yqZ2I8ECLyifkL6wTLeT
         wwcXBwI5QzK6/Oa1SZIkQBRw2HFwNwgMRzeqcxJL7aP6qzHcc93df697G57vCH9vNrZZ
         ruZJhIzkMQzQPGGfZShX8eo84TjlfbexB8UPQ=
Received: by 10.210.91.7 with SMTP id o7mr789843ebb.54.1249619972777;
        Thu, 06 Aug 2009 21:39:32 -0700 (PDT)
Received: from @ (91-164-150-22.rev.libertysurf.net [91.164.150.22])
        by mx.google.com with ESMTPS id 5sm1703176eyf.58.2009.08.06.21.39.31
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 21:39:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7GvFnE4br-8WnXmtoea9V1LPY-qshCw6arPr6H40SRG59-b7YcpTsw@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125175>

The 06/08/09, Brandon Casey wrote:

> The "former", or Junio's original patch, effectively has this form:
> 
>    {
>       sed "$1"
>    } < "$1"
> 
> Without reading closely enough, I thought it looked like this:
> 
>    {
>       sed
>    } < "$1"
> 
> Since I didn't study the sed statement closely enough, I assumed that it was
> operating on the remaining portion of the patch email that was redirected to
> the block on stdin.  I missed the fact that the file name was supplied to
> it.  My comment was that I found it strange (and maybe unintuitive, or maybe
> it's just me) that "$1" was piped on stdin and it was supplied as an
> argument to sed.

Thinking to this a bit more, I tend to think that your intention to get
rid of the "$1" argument of sed is the right thing to do.

It really seems like the argument has precedence to the redirection

  _but_

I couldn't find any reference to this case in POSIX and I guess that the
behaviour may differ between implementations of sed. I don't know.
Perhaps somebody could tell us if our hesitation is justified (or not)?

Finally and to prevent strange behaviours, I would write

  {
    real l1
    real l2
    real l3
    {
      echo "$l1"
      echo "$l2"
      echo "$l3"
      cat
    } | sed
  } < "$1"

instead of

  {
    real l1
    real l2
    real l3
    sed "$1"
  } < "$1"

because the latter may contain either the content of the whole file
(coming from the argument) or the content of the file _whithout_ the
first three lines (coming from the redirection '<' amputated by the
'read' statements).

Junio?

-- 
Nicolas Sebrecht
