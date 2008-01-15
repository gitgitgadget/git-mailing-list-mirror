From: "Mark Drago" <markdrago@gmail.com>
Subject: Re: [PATCH] hg-to-git: improve popen calls
Date: Tue, 15 Jan 2008 08:03:37 -0500
Message-ID: <af675f7f0801150503p26fba583tfb5827717b67705f@mail.gmail.com>
References: <478C0837.7090804@gmail.com>
	 <7vr6gjfl4z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, brian.ewins@gmail.com, stelian@popies.net
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 14:04:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JElSZ-0003UI-6c
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 14:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbYAONDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 08:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbYAONDj
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 08:03:39 -0500
Received: from hs-out-0708.google.com ([64.233.178.250]:54752 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750851AbYAONDi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 08:03:38 -0500
Received: by hs-out-2122.google.com with SMTP id 54so2290943hsz.5
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 05:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ekiWXeb1g/WCa9twvDKeXJIaX8S+7Ee+kxYbQsnbh14=;
        b=fAOTXI8Juh1uyKN5T52i75xhZ3p/hc2T3ZmxBpSEfnGxTBZZjvSXH+0zBSL9VK4J5wNmxtdoVpqal8V9OhcRGhD+X35RF+PWm2Rwt61RjrSt5ec++eEtH6sZX8/U0hWaiDWym9gwP6W6Zo/JvJ9H/It8cWDRD4VzFyZwWvrJPVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bdVFILZfj1ePR5g3/8ZhTHTiGtmYy7K7b75aF6oHL5CKX+AK/fq5UzmXzJFNY825KS08iBC39NxVCfjp+2Ho9xIn0gL2M0sRS1AjUczHJkeUdt81UQEPUxm3Gf0+aJh7LIF/zIVhDOMv4Is9fTyjvbqB1T28XmVjDUfN8kRonTc=
Received: by 10.142.158.17 with SMTP id g17mr3029257wfe.234.1200402217060;
        Tue, 15 Jan 2008 05:03:37 -0800 (PST)
Received: by 10.142.139.18 with HTTP; Tue, 15 Jan 2008 05:03:37 -0800 (PST)
In-Reply-To: <7vr6gjfl4z.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70520>

On Jan 15, 2008 5:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Mark Drago <markdrago@gmail.com> writes:
>
> > +    log_data = os.popen('hg log -r %d --template "{tags}\n{date|date}\n{author}\n"' % cset).readlines()
>
> I've already seen Stelian's Ack, but just for my sanity, let me
> make sure one thing.  The above {date|date} is correct, not a
> typo?

Yeah.  Everything after the pipe character is a filter and there is a
template keyword and a filter that are both called 'date'.

mdrago@laptop:~/Code/trunk$ hg log -r 4 --template '{date}\n'
1197080765.018000
mdrago@laptop:~/Code/trunk$ hg log -r 4 --template '{date|date}\n'
Fri Dec 07 21:26:05 2007 -0500

Mark.
