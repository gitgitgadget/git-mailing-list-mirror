From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 09/11] connect: use "-l user" instead of "user@" on ssh
 command line
Date: Tue, 3 May 2016 18:25:05 +0200
Message-ID: <8f470378-07a9-525b-ff8b-f0de011019cb@web.de>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462265452-32360-1-git-send-email-mh@glandium.org>
 <1462265452-32360-10-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, tboegi@web.de
To: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 18:25:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axd8X-0004lw-7H
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 18:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933721AbcECQZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 12:25:21 -0400
Received: from mout.web.de ([212.227.15.3]:61423 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932543AbcECQZU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 12:25:20 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MfqC4-1bKeAQ3le0-00NAmZ; Tue, 03 May 2016 18:25:06
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <1462265452-32360-10-git-send-email-mh@glandium.org>
X-Provags-ID: V03:K0:UTI9zwTQepuzMpi6jbbBAgHcfWoSVqZF7j3NqAUv8jMxZYxe8uN
 oJSp0HegV/odol5nOQ4cAJP1wmyFHmDRBGfoN81qUnNvNtGjTy6eO7vmZYXV9nYCaZEtPHh
 6FO6SxIWVVTIoUzce3m8hY2i0C3VKIixxWlex+BopVbZoEU+X5pT46TqeoFdZIx39YA4vGx
 m8JlfDCxnXfAqwmBFQibQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QAXOSFg4KQI=:24ZwogIDsa0kmeqPlEKKUu
 F8WRvV7+qHa/oxbq5G7Bx04+hJZWgFO9MqnqHKom5vUC8M9hC7NX3ZPT12uDYBJ6Sz0mLURFW
 +jdl9dGmgj0S75oTX+X1futuJRdwCdkklHQvIRQKBgpa/vmX7pNI4/fXgD90S3VDvh3mbP97E
 IHTU0tSNdX0AWeOLz9OFd4M8hpXYqblfw85hf2YPvOk5CSqGpxaF6la0d5oKI818PS0AgKSDW
 ix23QypL8Crem+rsn58UzEkPhgVf8bZX3oIwd+IZRqFRXr06lZ1dezQ+e+C00ztJjxzuGyUL5
 18j0lQm4s/rP/WHldjCPkqoL015LK5ejSlNNTzUjK7kQmS+YY6o3R7VmOn3Su/VXBaYO9qffY
 f+l6nmnoqQHsZYSq9MS1rn5G3k85Bk+RoJJikBt1Qa1zFhwLiMKk8+rJCponLmpKb4IlFu1n8
 VyGVS+2DHpgUZq+lMIx2n8BAN19V23CIEenPif2Sm8TGegCXh7zBmeGXRYVpOuM+WVt3SDA4V
 n25MJjW1/4qG7iJuuxEb8gf7qRN87E17PHW6C9x04ZFuZ/jjYunUEumQPC0emgrkN6bCNKz8G
 yV1q9wAKC2fn+2yqzjsjPcj5dbfbZUD5AWulSfek8elw/1p646CUcUpr4Fwbirx+wuhikw1Ul
 3gJd3xO26PKKhraZW8Iu87yVfY+wNdwExld+HT/D7Ku7nFS+dpeary3aoKikZh2g/jCajxHau
 sPjgAqJbAL6WVvOuiHu697fvjh8Q+tBEM9FWB9sEqKMoArwa0SKnheC6dB9RqWdyDLjD1+6h 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293414>

On 2016-05-03 10.50, Mike Hommey wrote:
> While it is not strictly necessary, it makes the connect code simpler
> when there is user.
> 

That commit message does't tell too much, I think.

Besides that, I'm sure it will break (at least) my ssh wrapper scripts,
which rely on user@host to be passed into the script.

The thing is that some hosts don't have a DNS entry, but can be reached via
host.local, if avahi is running.
And my wrapper script parses the url, looks up the host via netlookup,
or avahi using host.local, and feeds the result into /usr/bin/ssh.
