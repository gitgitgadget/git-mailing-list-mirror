From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Gitweb: Convert UTF-8 encoded file names
Date: Thu, 15 May 2014 12:38:34 -0700
Message-ID: <xmqqmweiessl.fsf@gitster.dls.corp.google.com>
References: <20140514184145.GA25699@localhost.localdomain>
	<xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>
	<CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com>
	<20140515050820.GA30785@localhost.localdomain>
	<alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se>
	<20140515184808.GA7964@localhost.localdomain>
	<CANQwDwe+GJ+yAYWdVfMaHq97zGXBoepCfUdLiaQD9LFoz3SiOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Wagner <accounts@mwagner.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	git <git@vger.kernel.org>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 21:50:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl1fd-0007AS-TI
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 21:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851AbaEOTuU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 May 2014 15:50:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59057 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633AbaEOTuS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 May 2014 15:50:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 195D4164B5;
	Thu, 15 May 2014 15:50:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ydBUhGgUeqOo
	V9T1a4jZeQosF1A=; b=wwEtBZzjwW4AUwMmvkC8XKAMq4D8W5DxgbjppIOFx3cA
	gEEa4IbtQ1KOUWRRVZB5hbqRoFyLJbGyH9W4me1o7P0orVUXUvr2AnLJ8feg1Udi
	im9xhtpUU7u8Prp7GqzkPcsjRM1vLJiG6CPk/qDc786QO1I4c3bD4vlzesOUpIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UdduzM
	1dw3BL468UNsuQmnfwJLKWbfnTpoIiQE+2FTRHjrsYV4WaSAF8MXUSX7wvPHqFyL
	MMTyDQeKOpYKhPGiN4PlsR2XtWj3JGoOZiTzGBnAH014yPBOsvFChfb9RIJ0mrKW
	xK2CvDleGqGq2ZG7dLCrXw1yD/3rymfxBWNwc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F3BE164B4;
	Thu, 15 May 2014 15:50:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5256D17B23;
	Thu, 15 May 2014 15:38:36 -0400 (EDT)
In-Reply-To: <CANQwDwe+GJ+yAYWdVfMaHq97zGXBoepCfUdLiaQD9LFoz3SiOA@mail.gmail.com>
	("Jakub =?utf-8?Q?Nar=C4=99bski=22's?= message of "Thu, 15 May 2014
 21:28:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 81CA7F0A-DC68-11E3-9740-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249195>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> Writing test for this would not be easy, and require some HTML
> parser (WWW::Mechanize, Web::Scraper, HTML::Query, pQuery,
> ... or low level HTML::TreeBuilder, or other low level parser).

Hmph.  Is it more than just looking for a specific run of %xx we
would expect to see in the output of the tree view for a repository
in which there is one tree with non-ASCII name?

>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index a9f57d6..f1414e1 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -7138,7 +7138,7 @@ sub git_tree {
>>         my @entries =3D ();
>>         {
>>                 local $/ =3D "\0";
>> -               open my $fd, "-|", git_cmd(), "ls-tree", '-z',
>> +               open my $fd, "-|encoding(UTF-8)", git_cmd(), "ls-tre=
e", '-z',
>>                         ($show_sizes ? '-l' : ()), @extra_options, $=
hash
>>                         or die_error(500, "Open git-ls-tree failed")=
;
>
> Or put
>
>                    binmode $fd, ':utf8';
>
> like in the rest of the code.

I expect a patch to do so and can forget about this thread myself,
then, OK?

Thanks all for digging this to the root.
