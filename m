From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Creating own hierarchies under $GITDIR/refs ?
Date: Sun, 2 Feb 2014 19:00:12 +0700
Message-ID: <CACsJy8A44EoxEb3b=ZZ-jgLLtn1ttr0P8gGwWJ2dNYCWi3MRUw@mail.gmail.com>
References: <87a9e92424.fsf@fencepost.gnu.org> <CACsJy8CdKRQ_au3QqVoUdedvPpkPh_2vodKJwLZ7VrrwRJSDXQ@mail.gmail.com>
 <8761ox2240.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Feb 02 13:01:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9vje-0005yz-HG
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 13:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbaBBMAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 07:00:44 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:62119 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbaBBMAn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 07:00:43 -0500
Received: by mail-qc0-f175.google.com with SMTP id x13so9496346qcv.6
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 04:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NjTivm6CsthWcRK/hcBYxEDzfbCljW0kudloZi9s2/U=;
        b=on+68/ZlIk5mbMXMWo3ByTMLDYoJSf0l3gwAFs1tbb0UcWsMa2pQ2P/M+2S4eO/7v2
         Q5yYodoMHdL/WYkPGluY3MTsz3T0JA+bEBkqOy2IooPykuXrZQuhYQHXIn37325/+gjT
         rfYCM7wB6Sp9I986632spBZpPQgntTHw6t4xhKp1QHABnCnopoiO2oc6LDUWQRceKLNq
         6CTY3zWkTmLoenlyZyvkXhK7hnJkD1RFPO51encaqSLVYVegZiigUV+9E95iF7+e9Gv2
         YsZIDe1WMLwhfeP++YuiaQgD6y70TYYkOgwm2PD9uS85EcXeptpwDjeczPwmRoILCGRv
         NJ1w==
X-Received: by 10.229.219.5 with SMTP id hs5mr47183712qcb.9.1391342442695;
 Sun, 02 Feb 2014 04:00:42 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Sun, 2 Feb 2014 04:00:12 -0800 (PST)
In-Reply-To: <8761ox2240.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241366>

On Sun, Feb 2, 2014 at 6:19 PM, David Kastrup <dak@gnu.org> wrote:
> Since Git has a working facility for references that is catered to do
> exactly this kind of mapping and already _does_, it seems like a
> convenient path to explore.

It will not scale. If you make those refs available for
cloning/fetching, all of them will be advertised first thing when git
starts negotiate. Imagine thousands of refs (and keep increasing) sent
to the receiver at the beginning of every connection. Something like
"reverse git-notes" may transfer more efficiently. Or we need to
improve git protocol to handle massive refs better, something that's
been discussed for a while without any outcome.
-- 
Duy
