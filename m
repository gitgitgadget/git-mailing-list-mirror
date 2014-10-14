From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 0/4] Allow building Git with Asciidoctor
Date: Tue, 14 Oct 2014 12:07:51 +0200
Message-ID: <543CF5F7.5060704@gmail.com>
References: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net> <xmqqtx371z44.fsf@gitster.dls.corp.google.com> <20141014003451.GA7041@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 14 12:08:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdz1T-0007lt-Ef
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 12:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbaJNKID convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Oct 2014 06:08:03 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:58687 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886AbaJNKIA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 06:08:00 -0400
Received: by mail-la0-f50.google.com with SMTP id s18so8201600lam.37
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 03:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=A9nJTCepqWGWOh4cp8++u8xT/rzZhmv+lPQclIJkJeI=;
        b=ViQtywVdtfS9EXip/SzIh7NmT3+0m+W795ccRBCLLFk945x03IunXuIQ0bJnhRPbXr
         n8z+X2ACvNzm5u1acgGuRCbiavrQl0bpx1xhXAMhKSnXShpNHs+gmkt1oci5Yjyv1VtS
         WM0LhvF2kojhAB/wZJBkc1wRK8Aj7FabAm/xPPFgyo8z5YUElX169r3hDFOWQsx4WPnK
         OvNtUdM8itbqsK6zflG8kHURpHHlStMplCXLBlLvJHJNtNZWCEVNo+iCeysNsihsJIbR
         giE4Sxtkz1p7b0028maYfwvTyh7lrlWWrdb6Tyei6DUKKa6tXTKy+qCUMBGIIay1F3vB
         ZbGA==
X-Received: by 10.153.6.38 with SMTP id cr6mr4420151lad.52.1413281278931;
        Tue, 14 Oct 2014 03:07:58 -0700 (PDT)
Received: from [192.168.130.235] ([158.75.2.130])
        by mx.google.com with ESMTPSA id t6sm4287051lbb.23.2014.10.14.03.07.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 03:07:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20141014003451.GA7041@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On Mon, Oct 13, 2014 at 01:41:31PM -0700, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>
>>> The second two patches implement some basic support for building wi=
th
>>> Asciidoctor.  The first of these moves some items into variables du=
e to
>>> some differences between the AsciiDoc and Asciidoctor command lines=
=2E
>>> The user can then override these values when invoking make.
>>>
>>> The final patch adds support for the linkgit macro.  Asciidoctor us=
es
>>> Ruby extensions to implement macro support, unlike AsciiDoc, which =
uses
>>> a configuration file.
>>
>> What I do not understand is that 3/4 lets you drop inclusion of
>> asciidoc.conf which contains a lot more than just linkgit:
>> definition.
>
> Asciidoctor just doesn't understand the -f argument, so trying to pas=
s
> it is going to fail.  For Asciidoctor, you're going to want to do
> something like "-I. -rasciidoctor/extensions -rextensions" there
> instead.
>
> As for the rest of the asciidoc.conf file, the DocBook manpage header
> declarations are implemented automatically by Asciidoctor after my
> recent patches.  The paragraph hacks do not appear to be necessary wi=
th
> Asciidoctor, so they've been omitted.
>
> That leaves the attributes.  All but litdd are built-in to Asciidocto=
r,
> and I can reroll with a modification to extensions.rb that implements
> that one.

Would it be possible to automatically convert asciidoc.conf file to=20
Asciidoctor extension?

--=20
Jakub Nar=C4=99bski
