From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/2] submodule: fix confusing variable name
Date: Tue, 06 Aug 2013 19:33:16 +0200
Message-ID: <5201335C.5040001@web.de>
References: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net> <1375550060-5406-2-git-send-email-sandals@crustytoothpaste.net> <20130803181415.GF2893@elie.Belkin> <51FE90B8.8030203@web.de> <20130804212938.GL19369@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, judge.packham@gmail.com,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, gitster@pobox.com,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 19:33:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6l8U-0000XL-Dp
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 19:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756390Ab3HFRd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 13:33:26 -0400
Received: from mout.web.de ([212.227.15.14]:60490 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756339Ab3HFRdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 13:33:25 -0400
Received: from [192.168.178.41] ([91.3.171.84]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0M7n5k-1W29341tvk-00vSFx for <git@vger.kernel.org>;
 Tue, 06 Aug 2013 19:33:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130804212938.GL19369@paksenarrion.iveqy.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:ubIwBkrRjNAgnVEovm8Bfb4LXHwQJbf7MLdRlv+LW8/d2Qtx7d3
 qeFE0wGrI+BbeP12Bm+1NHWPCJF/mW0rQdwsHwae3K6DlijJIkqrE8RubkWbNBG5Z+gx1sV
 cDfnvl4nj/tef+lEOIavIgyzEooEzW/eboJZ2lDe8lrxEeIec1hdVjLyt9l9AxC2u8ZYohk
 IunOQka6veNg3U2icJHKQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231766>

Am 04.08.2013 23:29, schrieb Fredrik Gustafsson:
> On Sun, Aug 04, 2013 at 07:34:48PM +0200, Jens Lehmann wrote:
>> But we'll have to use sm_path here (like everywhere else in the
>> submodule script), because we'll run into problems under Windows
>> otherwise (see 64394e3ae9 for details). Apart from that the patch
>> is fine.
> 
> We're still using path= in the foreach-script. Or rather, we're setting
> it. From what I can see and from the commit message 64394e3ae9 it could
> possible be a problem.

The commit message of 64394e3ae9 explicitly talks about that one:

  We note that the foreach subcommand provides $path to user scripts
  (ie it is part of the API), so we can't simply rename it to $sm_path.

> Not sure how to solve it though... Just a simple correction would break
> all script depending on that.

That's exactly why that one is still there. We could deprecate it in
favor of $sm_path and remove it some time later, but I'm not convinced
it is an urgent issue. But me thinks the documentation of foreach should
be updated, as it still talks about $path.
