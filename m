From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] config: Add new option to open an editor.
Date: Sat, 7 Feb 2009 23:15:30 +0200
Message-ID: <94a0d4530902071315o78b2db58n481fbc6e956b5b64@mail.gmail.com>
References: <94a0d4530902040741t4333b132v886d7057353ed52a@mail.gmail.com>
	 <1233786856-6571-1-git-send-email-felipe.contreras@gmail.com>
	 <7vmyd1lrnx.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0902050043000.10279@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.0902050049240.10279@pacific.mpi-cbg.de>
	 <94a0d4530902071309l7c34945ana2af31e41707fa0c@mail.gmail.com>
	 <alpine.DEB.1.00.0902072214410.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 07 22:17:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVuY0-0008EJ-4H
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 22:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbZBGVPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 16:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbZBGVPf
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 16:15:35 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:5082 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbZBGVPe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 16:15:34 -0500
Received: by fg-out-1718.google.com with SMTP id 16so798194fgg.17
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 13:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P7K3UdM2AyVwKXQ2a4n4vklcqF0wqIEbL6NPq66Qn0w=;
        b=VwMcn4dmylXCurvFYz/gjTgO5ZilWeA+hOtGxKA6zZN0Uf5cMHNyrT+IWQXi+68mge
         lQCt7vD61+bzO+IM6kB+4ziYgneS+bNYGaInD81atFGo7EGIAk0u2ZitINX2A2p0jDsr
         95LGoEWO1ZjPYzTUgC+KUp0JLV1cDnvx4+P4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YUyHZ33oY2LxAlta9TKLCvUhQo8gpD9QtYTP/KjyXq1tAs7pY6gXgCHHBOpDsObcr7
         VAu6A4g1EOM3bbf+o3fuRSAirtPjiSUUBappaZbTsOqOnuQqIKMU3d8NMEZp1cJiC6rz
         wSyJ9i7Ehfak1axTSJTneKI5IBchO5jB6Xcgo=
Received: by 10.86.59.18 with SMTP id h18mr1817246fga.57.1234041331406; Sat, 
	07 Feb 2009 13:15:31 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902072214410.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108881>

On Sat, Feb 7, 2009 at 11:14 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 7 Feb 2009, Felipe Contreras wrote:
>
>> On Thu, Feb 5, 2009 at 1:49 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > Hi,
>> >
>> > On Thu, 5 Feb 2009, Johannes Schindelin wrote:
>> >
>> >> On Wed, 4 Feb 2009, Junio C Hamano wrote:
>> >>
>> >> > Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >> >
>> >> > > The idea was originated by discussion about usability of manually
>> >> > > editing the config file in 'special needs' systems such as Windows. Now
>> >> > > the user can forget a bit about where the config files actually are.
>> >> >
>> >> > Does this honor core.editor setting in existing configuration files?
>> >>
>> >> It should, as it uses launch_editor().
>> >
>> > Oh, I see that launch_editor() does not do its own git_config() parsing.
>> > Dunno if it should...
>>
>> I think it should, how expensive would it be to call
>> git_config(git_default_config, NULL) when it has been loaded already?
>
> We would not need the complete git_default_config(), would we?

Nope, just core.editor. But I don't know how to load only that.

-- 
Felipe Contreras
