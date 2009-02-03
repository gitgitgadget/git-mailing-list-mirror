From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: Add new option to open an editor.
Date: Wed, 4 Feb 2009 01:43:06 +0200
Message-ID: <94a0d4530902031543t2928c9c4ta75132ddb4a9c52@mail.gmail.com>
References: <1233700826-11763-1-git-send-email-felipe.contreras@gmail.com>
	 <alpine.DEB.1.00.0902032350130.9822@pacific.mpi-cbg.de>
	 <94a0d4530902031456u1e1753e2rc34786ebdce6e774@mail.gmail.com>
	 <alpine.DEB.1.00.0902040002360.9822@pacific.mpi-cbg.de>
	 <94a0d4530902031525o11e512barfc2f50c33a520474@mail.gmail.com>
	 <alpine.DEB.1.00.0902040029040.9822@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 04 00:44:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUwb-00043D-Iy
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 00:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbZBCXnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 18:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbZBCXnJ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 18:43:09 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:3648 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbZBCXnI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 18:43:08 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1053227fgg.17
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 15:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=izXUgz2WHHKyjxVvGEU8aSGWNYstn689HX3kmNIZBDo=;
        b=O7TANNlSDjZ0lH5HRA42TOk/Qy21JkkEyj3DZegSKB1e4xazzmImZIsMl6bxyXD8P/
         DWchqGKli1jclqbYyZvcZ3yf736VokoGiWf1L6dyriGhfn2RyK/ru7oVrbaJ/fAVg+Ro
         HjYnh3eNoZqXh7a4s9Z55Xv64AxXL3rcnxqLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DCXUuivXX1jrBwnodA1LuPL8vs6qfMUziK+ifq1sexzXpftCV9znNpe3xPJ4CsXlRF
         mU12zDJ9vJvCkvfxK8iTNhFa3Yig2uLwPG5gWJCBxVLdF/EUoMv37r9I0OZem0qy0QaK
         7w5PLdercPNzdaPEOgiDkJB14loZMCIj48nrQ=
Received: by 10.86.59.18 with SMTP id h18mr3245568fga.45.1233704586258; Tue, 
	03 Feb 2009 15:43:06 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902040029040.9822@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108278>

On Wed, Feb 4, 2009 at 1:31 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 4 Feb 2009, Felipe Contreras wrote:
>
>> On Wed, Feb 4, 2009 at 1:05 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > On Wed, 4 Feb 2009, Felipe Contreras wrote:
>> >
>> >> On Wed, Feb 4, 2009 at 12:53 AM, Johannes Schindelin
>> >> <Johannes.Schindelin@gmx.de> wrote:
>> >>
>> >> > However, a test case would be nice...
>> >>
>> >> What would the the test case check?
>> >
>> > That 'GIT_CONFIG=bla GIT_EDITOR=echo git config -e' and 'GIT_DIR=blub
>> > GIT_EDITOR=echo git config -e' do the right thing.  Maybe even
>> > --global, but that would also be a good test that "git config --global
>> > -e" does not fail when there is no original file.
>>
>> Hmm, I'm not sure what issues this test case would find. If there's a
>> problem with launch_editor that's something other test case should find.
>
> The purpose of the test case is not to find problems now, but ensure that
> what the patch is intended to do does not get broken by subsequent
> patches.

I know, I wonder what kinds of possible problems this test case would find.

>> If there's no original file it's up to the editor to create one, if for
>> some reason the editor fails at doing that it's a problem of the editor,
>> and there's not much 'git config -e' could do except show an error, and
>> that's what launch_editor would do. Same thing if the editor is wrong
>> (GIT_EDITOR=blah).
>
> I was more thinking about 'git config --global -e' complaining that it
> could not find a non-existant file _before_ launching the editor.
>
> Likewise, GIT_EDITOR=echo was meant to output the filename, not to edit
> the file.

You mean if somebody for some reason decides to do some extra checking
on the config_filename before executing launch_editor? I seriously
doubt anything more would be needed for this --edit option. Can this
patch be acked as it is?

-- 
Felipe Contreras
