From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 02/15] mingw: implement syslog
Date: Mon, 11 Oct 2010 17:11:46 -0500
Message-ID: <20101011221146.GB6277@burratino>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-3-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com,
	Mike Pape <dotzenlabs@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 00:15:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5QeK-0002mV-3V
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 00:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756735Ab0JKWPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 18:15:04 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49594 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756699Ab0JKWPD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 18:15:03 -0400
Received: by gxk6 with SMTP id 6so282414gxk.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 15:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yJ0cLzKQqbDrw+Z0xDexj9Q0TxmBtuL+Msi+LvHXs0Q=;
        b=W8sE5iLu38qKTYuxHJwTuclsrBOI3ql4kV0lRTWQImXls2FDuSCLKrVmsXZ+ILNIJv
         SiQ0zNITiOlut5TOANL1yHx0ocoa7w+rfJw8Z6O72rIkgrgkBwoEEnGlTdUDTV6WZYLi
         5+sW9CwWqiW1qu9dYuaBmGorGN0jb2GGYbKU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=D2GQM+cI779CTwFiesOnaA7GqdS0Zz3JFb63UxSPjt9LsSbeGr7Eez/ZrkLX9Ss+oK
         B43MoRVO5ywp+059p0tByibE7f71Bebj33A1/++3N8lCtunrx2XcMRO4K155YldPMXAt
         D4aLTRC7KLzfUImlw0I0d4lXJe3RlCiT7tF1g=
Received: by 10.101.147.32 with SMTP id z32mr3165122ann.150.1286835302917;
        Mon, 11 Oct 2010 15:15:02 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x32sm9312387anx.4.2010.10.11.15.15.01
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 15:15:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286833829-5116-3-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158809>

Erik Faye-Lund wrote:

> Strings containing "%1" gets corrupted by ReportEvent, so expand
> "%1" to "% 1" before reporting.

What is the symptom?  Can clients trigger this, and is it worth
preventing them from doing so?
